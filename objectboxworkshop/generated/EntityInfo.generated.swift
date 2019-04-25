// Generated using the ObjectBox Swift Generator — https://objectbox.io
// DO NOT EDIT

// swiftlint:disable all
import ObjectBox

// MARK: - Entity metadata


extension Person: __EntityRelatable {
    typealias EntityType = Person

    var _id: Id<Person> {
        return self.id
    }
}

extension Person: EntityInspectable {
    /// Generated metadata used by ObjectBox to persist the entity.
    static var entityInfo: EntityInfo {
        return EntityInfo(
            name: "Person",
            cursorClass: PersonCursor.self)
    }

    fileprivate static func buildEntity(modelBuilder: ModelBuilder) {
        let entityBuilder = modelBuilder.entityBuilder(for: entityInfo, id: 1, uid: 2914234788803921920)
        entityBuilder.addProperty(name: "id", type: Id<Person>.entityPropertyType, flags: [.id], id: 1, uid: 2701866560102641152)
        entityBuilder.addProperty(name: "name", type: String.entityPropertyType, id: 2, uid: 9208876307650295552)
        entityBuilder.addProperty(name: "age", type: Int.entityPropertyType, id: 3, uid: 2695418281637343232)

    }
}

extension Person {
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { Person.id == myId }
    static var id: Property<Person, Id<Person>> { return Property<Person, Id<Person>>(propertyId: 2701866560102641152, isPrimaryKey: true) }
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { Person.name.startsWith("X") }
    static var name: Property<Person, String> { return Property<Person, String>(propertyId: 9208876307650295552, isPrimaryKey: false) }
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { Person.age > 1234 }
    static var age: Property<Person, Int> { return Property<Person, Int>(propertyId: 2695418281637343232, isPrimaryKey: false) }

    fileprivate  func __setId(identifier: EntityId) {
        self.id = Id(identifier)
    }
}

/// Generated service type to handle persisting and reading entity data. Exposed through `Person.entityInfo`.
class PersonCursor: NSObject, CursorBase {
    func setEntityId(of entity: Any, to entityId: EntityId) {
        let entity = entity as! Person
        entity.__setId(identifier: entityId)
    }

    func entityId(of entity: Any) -> EntityId {
        let entity = entity as! Person
        return entity.id.value
    }

    func collect(fromEntity entity: Any, propertyCollector: PropertyCollector, store: Store) -> ObjectBox.EntityId {
        let entity = entity as! Person

        var offsets: [(offset: OBXDataOffset, index: UInt16)] = []
        offsets.append((propertyCollector.prepare(string: entity.name, at: 2 + 2 * 2), 2 + 2 * 2))

        propertyCollector.collect(entity.age, at: 2 + 2 * 3)


        for value in offsets {
            propertyCollector.collect(dataOffset: value.offset, at: value.index)
        }

        return entity.id.value
    }

    func createEntity(entityReader: EntityReader, store: Store) -> Any {
        let entity = Person()

        entity.id = entityReader.read(at: 2 + 2 * 1)
        entity.name = entityReader.read(at: 2 + 2 * 2)
        entity.age = entityReader.read(at: 2 + 2 * 3)



        return entity
    }
}


fileprivate func modelBytes() -> Data {
    let modelBuilder = ModelBuilder()
    Person.buildEntity(modelBuilder: modelBuilder)
    return modelBuilder.finish()
}

extension ObjectBox.Store {
    /// A store with a fully configured model. Created by the code generator with your model's metadata in place.
    ///
    /// - Parameters:
    ///   - directoryPath: Directory path to store database files in.
    ///   - maxDbSizeInKByte: Limit of on-disk space for the database files. Default is `1024 * 1024` (1 GiB).
    ///   - fileMode: UNIX-style bit mask used for the database files; default is `0o755`.
    ///   - maxReaders: Maximum amount of concurrent readers, tailored to your use case. Default is `0` (unlimited).
    convenience init(directoryPath: String, maxDbSizeInKByte: UInt64 = 1024 * 1024, fileMode: UInt32 = 0o755, maxReaders: UInt32 = 0) throws {
        try self.init(
            modelBytes: modelBytes(),
            directory: directoryPath,
            maxDbSizeInKByte: maxDbSizeInKByte,
            fileMode: fileMode,
            maxReaders: maxReaders)
        registerAllEntities()
    }
    func registerAllEntities() {
        self.register(entity: Person.self)
    }
}

// swiftlint:enable all
