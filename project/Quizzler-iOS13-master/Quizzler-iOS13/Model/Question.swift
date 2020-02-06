import Foundation

struct Question {

    let question: String
    let answer: [String]
    let correctAnswer: String

    init(q:String, a:[String], correctAnswer: String){
        self.question = q
        self.answer = a
        self.correctAnswer = correctAnswer
    }

}
