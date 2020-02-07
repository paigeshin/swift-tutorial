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
