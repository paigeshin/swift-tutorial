//
//  main.swift
//  TupleDataType
//
//  Created by shin seunghyun on 2020/02/23.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import Foundation

let touple1 = ("Angela", 12)
let touple2 = (name: "Angela", age: 12)
let touple3: (name: String, age: Int)
//touple3.name = "Angela"
//touple3.age = 18
touple3 = (name: "Angela", age: 2)

print(touple1.0)
print(touple2.name)
