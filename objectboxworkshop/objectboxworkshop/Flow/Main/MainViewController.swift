//
//  ViewController.swift
//  objectboxworkshop
//
//  Created by Lucas Torres Mezzari on 25/04/19.
//  Copyright © 2019 Lucas Torres Mezzari. All rights reserved.
//

import UIKit

enum CellType {
    case emptyCell
    case personCell
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView! {
        didSet{
            mainTableView.dataSource = self
            mainTableView.delegate = self
        }
    }
    
    let viewModel: MainControllerViewModel = MainControllerViewModel()
    
    var mainCellType: CellType {
        if viewModel.persons.isEmpty {
            return .emptyCell
        } else {
            return .personCell
        }
    }
    
    var formTableViewCell: PersonFormTableViewCell?
    
    var isEditingPerson: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return mainCellType == .emptyCell ? 1 : viewModel.persons.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonFormTableViewCell", for: indexPath)
            
            guard let formCell = cell as? PersonFormTableViewCell else {
                return cell
            }
            
            formCell.delegate = self
            formTableViewCell = formCell
            
            return formCell
        default:
            if mainCellType == .emptyCell {
                return tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath)
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PersonTableViewCell", for: indexPath)
                
                guard let personCell = cell as? PersonTableViewCell else {
                        return cell
                }
                
                let person = viewModel.persons[indexPath.row]
                personCell.delegate = self
                personCell.person = person
                
                return personCell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
}

extension MainViewController: PersonFormTableViewCellDelegate, PersonTableViewCellDelegate {
    func didPressSave(_ name: String, _ age: Int) {
        viewModel.save(isEditingPerson, name, age, { index, isFirst in
            if isFirst {
                mainTableView.reloadData()
            } else if isEditingPerson {
                isEditing = false
                mainTableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .automatic)
            } else {
                mainTableView.beginUpdates()
                mainTableView.insertRows(at: [IndexPath(row: index, section: 1)], with: .automatic)
                mainTableView.endUpdates()
            }
        }, { error in
            
        })
    }
    
    func didPressCell(_ person: Person) {
        guard let cell = formTableViewCell else {
            return
        }
        
        isEditingPerson = true
        viewModel.personId = person.id
        cell.nameTextField.text = person.name
        cell.ageTextField.text = String(person.age)
    }
}
