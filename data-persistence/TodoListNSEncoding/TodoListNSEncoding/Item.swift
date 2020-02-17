//
//  Item.swift
//  TodoListNSEncoding
//
//  Created by shin seunghyun on 2020/02/17.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import Foundation

struct Item : Encodable, Decodable {
    
    var title: String = ""
    var isDone: Bool = false
    
}
