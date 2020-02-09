//
//  QuestionBrain.swift
//  Quizzler-iOS13
//
//  Created by shin seunghyun on 2020/02/08.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct QuestionBrain {

    let questions: [Question] = [
        Question(q: "Which is the largest organ in the human body?", a: ["Heart", "Skin", "Large Intestine"], correctAnswer: "Skin"),
        Question(q: "Five dollars is worth how many nickels?", a: ["25", "50", "100"], correctAnswer: "100"),
        Question(q: "What do the letters in the GMT time zone stand for?", a: ["Global Meridian Time", "Greenwich Mean Time", "General Median Time"], correctAnswer: "Greenwich Mean Time"),
        Question(q: "What is the French word for 'hat'?", a: ["Chapeau", "Écharpe", "Bonnet"], correctAnswer: "Chapeau"),
        Question(q: "In past times, what would a gentleman keep in his fob pocket?", a: ["Notebook", "Handkerchief", "Watch"], correctAnswer: "Watch"),
        Question(q: "How would one say goodbye in Spanish?", a: ["Au Revoir", "Adiós", "Salir"], correctAnswer: "Adiós"),
        Question(q: "Which of these colours is NOT featured in the logo for Google?", a: ["Green", "Orange", "Blue"], correctAnswer: "Orange"),
        Question(q: "What alcoholic drink is made from molasses?", a: ["Rum", "Whisky", "Gin"], correctAnswer: "Rum"),
        Question(q: "What type of animal was Harambe?", a: ["Panda", "Gorilla", "Crocodile"], correctAnswer: "Gorilla"),
        Question(q: "Where is Tasmania located?", a: ["Indonesia", "Australia", "Scotland"], correctAnswer: "Australia")
    ]

    var questionIndex: Int = 0

    //question을 가져옴
    func getQuestion() -> Question {
        return questions[questionIndex]
    }

    //맞는 답인지 아닌지 확인해주는 함수
    func examineAnswer(userAnswer: String) -> Bool {
        let currentQuestion: Question = questions[questionIndex]
        if (currentQuestion.correctAnswer == userAnswer) {
            return true
        } else {
            return false
        }
    }

    //다음 question
    mutating func nextQuestion() -> Bool {
        if (questionIndex < questions.count - 1) {
            questionIndex += 1
            return true
        } else {
            questionIndex = 0
            return false
        }
    }

    func getProgressValue() -> Float {
        return Float(questionIndex + 1) / Float(questions.count)
    }

}
