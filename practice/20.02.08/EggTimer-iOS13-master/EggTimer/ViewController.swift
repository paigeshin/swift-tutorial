//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var eggTitle: UILabel!
    @IBOutlet weak var softEgg: UIButton!
    @IBOutlet weak var mediumEgg: UIButton!
    @IBOutlet weak var hardEgg: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!

    var timer = Timer()
    var audioPlayer: AVAudioPlayer!
    var cookTime = 0
    var totalCookTime = 0
    let eggTime = ["Soft": 30, "Medium": 60, "Hard": 90]

    @IBAction func eggButtonPressed(_ sender: UIButton) {
        eggTitle.text = "How do you like your eggs?"
        totalCookTime = eggTime[sender.currentTitle!]!
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startCook), userInfo: nil, repeats: true)
    }

    @objc func startCook() {
        if (cookTime < totalCookTime) {
            let progressValue = Float(cookTime) / Float(totalCookTime)
            progressBar.setProgress(progressValue, animated: true)
            cookTime += 1
        } else {
            progressBar.setProgress(0, animated: false)
            playFinishSound()
            eggTitle.text = "Cooking is finished!"
            timer.invalidate()
            cookTime = 0
        }
    }

    func playFinishSound() {
        if let soundURL = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            } catch {
                print(error)
            }
            audioPlayer.play()
        } else {
            print("Unable to locate audio file")
        }
    }


}
