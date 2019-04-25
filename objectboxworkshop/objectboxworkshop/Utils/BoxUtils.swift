//
//  BoxUtils.swift
//  objectboxworkshop
//
//  Created by Lucas Torres Mezzari on 25/04/19.
//  Copyright © 2019 Lucas Torres Mezzari. All rights reserved.
//

import UIKit
import ObjectBox

class BoxUtils {
    
    static var store: Store?
    
    static func initialize() {
        do {
            let directory = try FileManager.default.url(
                for: .applicationSupportDirectory,
                in: FileManager.SearchPathDomainMask.userDomainMask,
                appropriateFor: nil,
                create: true).appendingPathComponent(Bundle.main.bundleIdentifier!)
            if !FileManager.default.fileExists(atPath: directory.path) {
                try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: false, attributes: nil)
            }
            
            try store = Store(directoryPath: directory.path)
        } catch _ {
            return
        }
    }
    
    static func getBox<T>() -> Box<T>? {
        return store?.box(for: T.self)
    }

}
