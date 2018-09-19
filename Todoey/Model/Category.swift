//
//  Data.swift
//  Todoey
//
//  Created by Ercan GÜNBİLEK on 18.09.2018.
//  Copyright © 2018 Ercan GÜNBİLEK. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
