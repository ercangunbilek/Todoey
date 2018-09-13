//
//  Cell.swift
//  Todoey
//
//  Created by Ercan GÜNBİLEK on 11.09.2018.
//  Copyright © 2018 Ercan GÜNBİLEK. All rights reserved.
//

import Foundation

class Item : Codable{
    
    var title : String
    var done : Bool
    
    init(title : String , done : Bool) {
        self.done = done
        self.title = title
    }
}
