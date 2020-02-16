//
//  TodoList.swift
//  Todoey
//
//  Created by shin seunghyun on 2020/02/16.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct Item: Encodable, Decodable {
    var title: String = ""
    var done: Bool = false
}
