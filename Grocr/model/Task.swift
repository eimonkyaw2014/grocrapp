//
//  Task.swift
//  Grocr
//
//  Created by eimonkyaw on 7/14/20.
//  Copyright © 2020 eimonkyaw. All rights reserved.
//

import Foundation
struct Task {
    var name : String
    var done : Bool
    var id : String
    
    var dictionary: [String :Any]{
        return [
            "name" : name,
            "done" : done
        ]
    }
}
extension Task {
    init?(dictonary:[String:Any],id: String) {
        guard let name = dictonary["name"] as? String,
        let done = dictonary["done"] as? Bool
            else {return nil}
        self.init(name: name,done: done, id: id)
    }
}
