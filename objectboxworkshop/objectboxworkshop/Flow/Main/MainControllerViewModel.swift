//
//  MainControllerViewModel.swift
//  objectboxworkshop
//
//  Created by Lucas Torres Mezzari on 25/04/19.
//  Copyright © 2019 Lucas Torres Mezzari. All rights reserved.
//

import UIKit
import ObjectBox

class MainControllerViewModel {
    
    let personsBox: Box<Person>?
    
    var persons: [Person]
    var personId: Id<Person> = 0
    
    init() {
        personsBox = BoxUtils.getBox()
        persons = personsBox?.all() ?? []
    }
    
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
                    save(person)
                    success(index, false)
                }
                return
            }
            
            let index: Int = persons.count
            persons.append(person)
            save(person)
            success(index, isEmpty)
        }
    }
    
    private func save(_ person: Person) {
        do {
            try personsBox?.put(person)
        } catch _ {
            
        }
    }
}
