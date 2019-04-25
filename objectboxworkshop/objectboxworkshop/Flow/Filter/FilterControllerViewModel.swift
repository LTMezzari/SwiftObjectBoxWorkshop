//
//  FilterControllerViewModel.swift
//  objectboxworkshop
//
//  Created by Lucas Torres Mezzari on 25/04/19.
//  Copyright © 2019 Lucas Torres Mezzari. All rights reserved.
//

import UIKit
import ObjectBox

class FilterControllerViewModel {
    
    lazy var personsBox: Box<Person>? = BoxUtils.getBox()
    
    func filter(_ identifier: String, _ name: String, _ age: Int, _ startPeriod: Int, _ endPeriod: Int, _ success: ([Person]) -> Void) {
        guard let box = personsBox else {
            return
        }
        
        let query: Query<Person>
        
        if (!identifier.isEmpty) {
            query = box.query({
                return Person.id.isEqual(to: EntityId())
            })
        } else {
            query = box.query({
                var condition: QueryCondition<Person> = Person.name.contains("")
                if !name.isEmpty {
                    condition = Person.name.contains(name)
                }
                
                if age > 0 {
                    condition = condition && Person.age.isEqual(to: age)
                } else if startPeriod > 0 && endPeriod > 0 {
                    condition = condition && Person.age.isBetween(startPeriod, and: endPeriod)
                }
                return condition
            })
        }
        
        success(query.find())
    }
}
