//
//  Person.swift
//  objectboxworkshop
//
//  Created by Lucas Torres Mezzari on 25/04/19.
//  Copyright © 2019 Lucas Torres Mezzari. All rights reserved.
//

import UIKit
import ObjectBox

class Person: Entity {
    var id: Id<Person> = 0
    var name: String = ""
    var age: Int = 0
    
    required init() {
        
    }
}
