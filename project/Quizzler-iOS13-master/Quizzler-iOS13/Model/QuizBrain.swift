//
// Created by shin seunghyun on 2020/02/06.
// Copyright (c) 2020 The App Brewery. All rights reserved.
//

import Foundation

struct QuizBrain {

    let quiz = [
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

    var questionNumber:Int = 0
    var count:Int = 0
    var progressValue:Float = 0;

    mutating func checkAnswer(_ userAnswer: String) -> Bool {
        if (userAnswer == quiz[questionNumber].correctAnswer) {
            count += 1
            return true
        } else {
            return false
        }
    }

    func getCount() -> Int {
        return count
    }

    //mutating
    mutating func nextQuestion(){
        if(questionNumber + 1 < quiz.count){
            questionNumber += 1
        } else {
            questionNumber = 0
            count = 0
            progressValue = 0
        }
    }

    func getQuestion() -> String {
        return quiz[questionNumber].question
    }

    func getAnswers() -> [String] {
        return quiz[questionNumber].answer
    }

    mutating func getProgressValue() -> Float {
        progressValue = Float(questionNumber + 1) / Float(quiz.count)
        return progressValue
    }


    
}

