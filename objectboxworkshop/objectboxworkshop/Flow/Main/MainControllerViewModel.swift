//
//  MainControllerViewModel.swift
//  objectboxworkshop
//
//  Created by Lucas Torres Mezzari on 25/04/19.
//  Copyright © 2019 Lucas Torres Mezzari. All rights reserved.
//

import UIKit

class MainControllerViewModel {
    
    var persons: [Person] = []
    var personId: CLong = 0
    
    func save(_ isEditing: Bool, _ name: String, _ age: Int, _ success: (Int, Bool) -> Void, _ error: (String) -> Void) {
        if !name.isEmpty && age > 0 {
            let isEmpty: Bool = persons.isEmpty
            let person: Person = Person()
            person.name = name
            person.age = age
            
            if (isEditing) {
                person.id = personId
                let index: Int = persons.index(where: { (item) -> Bool in
                    item.id == person.id
                }) ?? -1
                
                if index != -1 {
                    persons[index] = person
                    success(index, false)
                }
                return
            }
            
            let index: Int = persons.count
            persons.append(person)
            success(index, isEmpty)
        }
    }
}
