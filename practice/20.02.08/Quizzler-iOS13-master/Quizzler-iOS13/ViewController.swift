//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var questionButton1: UIButton!
    @IBOutlet weak var questionButton2: UIButton!
    @IBOutlet weak var questionButton3: UIButton!

    @IBOutlet weak var progressBar: UIProgressView!

    var questionBrain:QuestionBrain = QuestionBrain()
    var timer:Timer!
    var score:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    }

    @IBAction func buttonPressed(_ sender: UIButton) {

        let isCorrect = questionBrain.examineAnswer(userAnswer: sender.currentTitle!)

        if(isCorrect){
            sender.backgroundColor = UIColor.green
            score += 1
            scoreLabel.text = "score: \(score)"
        } else {
            sender.backgroundColor = UIColor.red
        }

        let isValidIndex = questionBrain.nextQuestion()

        if(isValidIndex){
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(update), userInfo: nil, repeats: false)
        } else {
            progressBar.setProgress(0, animated: false)
            scoreLabel.text = "score: 0"
        }

    }
    

    @objc func update(){
        let question = questionBrain.getQuestion()
        let progressValue:Float = questionBrain.getProgressValue()
        progressBar.setProgress(progressValue, animated: true)
        questionLabel.text = question.question
        questionButton1.backgroundColor = UIColor.clear
        questionButton2.backgroundColor = UIColor.clear
        questionButton3.backgroundColor = UIColor.clear
        questionButton1.setTitle(question.answer[0], for: .normal)
        questionButton2.setTitle(question.answer[1], for: .normal)
        questionButton3.setTitle(question.answer[2], for: .normal)
    }


}

