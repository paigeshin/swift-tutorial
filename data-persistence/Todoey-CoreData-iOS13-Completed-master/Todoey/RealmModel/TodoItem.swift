//
//  Item.swift
//  Todoey
//
//  Created by shin seunghyun on 2020/02/18.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation
import RealmSwift

class TodoItem: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    //Relationship - Inverse Relationship of Items, one to one => Inverse Relationship
    var parentCategory: LinkingObjects = LinkingObjects(fromType: TodoParent.self, property: "items")
}
