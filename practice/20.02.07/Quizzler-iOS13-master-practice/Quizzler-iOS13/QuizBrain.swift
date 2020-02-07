import Foundation

struct QuizBrain {

    var questions: [Question] = [
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

    var currentPosition = 0
    var score = 0

    func getQuestion() -> Question {
        return questions[currentPosition]
    }

    mutating func nextQuestion() {
        if (currentPosition < questions.count - 1) {
            currentPosition += 1
            score += 1
        } else {
            currentPosition = 0
            score = 0
        }
    }

    func decideAnswer(answer: String) -> Bool {
        let correctAnswer = questions[currentPosition].correctAnswer
        if (answer == correctAnswer) {
            return true
        }
        return false
    }

    mutating func getProgressValue() -> Float {
        return Float(currentPosition + 1) / Float(questions.count)
    }

    func getScore() -> Int {
        return score
    }

}
