//
//  TodoItem.swift
//  ToDoListPractice
//
//  Created by shin seunghyun on 2020/02/16.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import Foundation

struct TodoItem : Encodable, Decodable{

    var title: String = ""
    var isDone: Bool = false
    
}
