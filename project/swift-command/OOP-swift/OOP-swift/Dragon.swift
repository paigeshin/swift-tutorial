//
//  Dragon.swift
//  OOP-swift
//
//  Created by shin seunghyun on 2020/02/07.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import Foundation

class Dragon:Enemy {
    
    var wingSpan:Int = 2

    
    func talk(speech: String){
        print("Says: \(speech)")
    }
    
    override func move() {
        print("Fly forwards")
    }
    
    override func attack() {
        super.attack()
        print("Spits Fire, does 10 damage")
    }
    
}
