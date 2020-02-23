//
//  StructEample.swift
//  Struct vs Class
//
//  Created by shin seunghyun on 2020/02/23.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import Foundation

struct StructHero {
    
    let name: String
    let universe: String

    mutating func reverseName() -> String {
        return String(self.name.reversed())
    }
    
}


