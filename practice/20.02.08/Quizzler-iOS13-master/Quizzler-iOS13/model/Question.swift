//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by shin seunghyun on 2020/02/08.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct Question{

    let question:String
    let answer:[String]
    let correctAnswer:String

    init(q:String, a:[String], correctAnswer:String){
        self.question = q
        self.answer = a
        self.correctAnswer = correctAnswer
    }

}
