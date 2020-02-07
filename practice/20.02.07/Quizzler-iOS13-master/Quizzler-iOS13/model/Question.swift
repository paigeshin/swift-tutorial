//
// Created by shin seunghyun on 2020/02/07.
// Copyright (c) 2020 The App Brewery. All rights reserved.
//

import Foundation

struct Question {

    var question:String
    var answer:[String]
    var correctAnswer:String

    init(q:String, a:[String], correctAnswer:String){
        self.question = q
        self.answer = a
        self.correctAnswer = correctAnswer
    }
}
