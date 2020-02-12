//
//  main.swift
//  loop_project
//
//  Created by shin seunghyun on 2020/02/12.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import Foundation

func fibonnacci(n: Int) -> [Int] {
    
    var array:[Int] = []
    
    for index in 0...n-2 {
        
        if(index == 0){
            array.append(index)
        }
        
        if(index == 1){
            array.append(index)
        }
        
        if(array.count > 1){
            array.append(array[index - 1] + array[index])
        }
        
    }
    
    print(array)
    return array
    
}

fibonnacci(n: 10)






