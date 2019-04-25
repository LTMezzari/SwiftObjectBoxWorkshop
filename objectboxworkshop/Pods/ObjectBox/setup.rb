#!/usr/bin/env ruby

require "xcodeproj"

##
## Figure out app project path
##

OBJECTBOX_POD_ROOT = File.expand_path(File.dirname(__FILE__))
PROJECT_ROOT = File.expand_path(File.join(File.dirname(__FILE__), "..", ".."))

if ARGV.size > 0
  PROJECT_FILE_NAME = ARGV[0]
  project_path = File.join(PROJECT_ROOT, PROJECT_FILE_NAME)
  if !File.exists?(project_path)
    puts "Could not find Xcode project at \"#{project_path}\""
    exit 1
  end
else
  puts "Recommended usage:   #{__FILE__} ProjectName.xcodeproj"
  puts ""
  PROJECT_BASENAME = File.basename(PROJECT_ROOT)
  puts "Trying to find project named like parent folder \"#{PROJECT_BASENAME}\"."

  project_path = File.join(PROJECT_ROOT, "#{PROJECT_BASENAME}.xcodeproj")
  if !File.exists?(project_path)
    puts "Not found. Taking first project file from the current directory ..."
    project_files = Dir.glob(File.join(PROJECT_ROOT, "*.xcodeproj"))
    if project_files.empty?
      puts "Could not find a project file in \"#{PROJECT_ROOT}\"."
      exit 1
    end
    project_files.sort_by!{ |m| m.downcase } # Make following call more deterministic.
    project_path = project_files[0] # Take first project file ¯\_(ツ)_/¯
  end
end

puts "Using \"#{project_path}\""

##
## Add the generated Swift files to the project
##

GENERATED_DIR_NAME = "generated"
GENERATED_DIR_PATH = File.join(PROJECT_ROOT, GENERATED_DIR_NAME)
GENERATED_FILE_NAME = "EntityInfo.generated.swift"
GENERATED_CODE_PATH = File.join(GENERATED_DIR_PATH, GENERATED_FILE_NAME)

SOURCERY_BUILD_PHASE_NAME = "[OBX] Update Sourcery Generated Files"

project = Xcodeproj::Project.open(project_path)
app_targets = project.targets.select { |t| t.launchable_target_type? }

generated_groupref = project.groups
  .select { |g| g.path == GENERATED_DIR_NAME }
  .first
if generated_groupref.nil?
  puts "Adding a new group for generated files at `./#{GENERATED_DIR_NAME}/`..."

  generated_groupref = project.new_group("generated", GENERATED_DIR_NAME)

  # Move group from the end to before the build Products
  products_group_index = project.main_group.children.index { |g| g.name == "Products" } || 2
  project.main_group.children.insert(products_group_index, project.main_group.children.delete(generated_groupref))
end

generated_fileref = generated_groupref.files
  .select { |f| f.path == GENERATED_FILE_NAME }
  .first
if generated_fileref.nil?
  puts "Adding code generator output files to project #{project.root_object.name} ..."

  # Create placeholder files so Xcode finds the references
  puts "  Creating files ..."
  FileUtils.mkdir_p(GENERATED_DIR_PATH)
  File.open(GENERATED_CODE_PATH, 'w') do |file|
    file.puts("// Build your project to run Sourcery and create contents for this file\n")
  end

  puts "  Inserting generated file into group \"#{generated_groupref.name}\" ..."
  generated_fileref = generated_groupref.new_file(GENERATED_CODE_PATH)

  puts "  Adding generated file to targets ..."
  app_targets.each do |target|
    puts "    - #{target.name}"
    target.add_file_references([generated_fileref])
  end
end

##
## Add Sourcery script generation phase before code compilation
##

app_targets.each do |target|
  # Change target only if it doesn't have the build phase already
  next unless nil == target.build_phases.index { |p| p.respond_to?(:name) && p.name == SOURCERY_BUILD_PHASE_NAME }

  codegen_phase = target.new_shell_script_build_phase(SOURCERY_BUILD_PHASE_NAME)

  codegen_phase.shell_script = "\"$PODS_ROOT/ObjectBox/generate_sources.sh\""

  puts "Adding code generation phase to target \"#{target.name}\" ..."

  # Move code gen phase to the top, before compilation
  compile_phase_index = target.build_phases.index { |p| p.is_a?(Xcodeproj::Project::Object::PBXSourcesBuildPhase) } || 0
  target.build_phases.insert(compile_phase_index, target.build_phases.delete(codegen_phase))
end

##
## Save Changes to the Project
##

if project.dirty?
  puts "\nSaving project changes ..."
  project.save
end
