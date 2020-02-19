//
//  Category.swift
//  Todoey
//
//  Created by shin seunghyun on 2020/02/18.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation
import RealmSwift

class TodoParent: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    
    //Relationship - Inside of the each Category, it contains items, `One to Many` => Forward Relationship
    let items: List<TodoItem> = List<TodoItem>()
}
