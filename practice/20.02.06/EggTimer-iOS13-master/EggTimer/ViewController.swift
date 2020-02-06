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
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    let eggDictionary = ["Soft": 180, "Medium": 240, "Hard": 300]
    
    var player:AVAudioPlayer!
    var seconds = 0;
    var totalSeconds = 0;
    var timer = Timer();
    
    @IBAction func eggPressed(_ sender: UIButton) {
        labelTitle.text = "How do you like your eggs?"
        let hardness = sender.currentTitle!
        
        seconds = 0;
        totalSeconds = 0;
        progressBar.setProgress(0, animated: false)
        
        timer.invalidate()
        totalSeconds = eggDictionary[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @objc func update(){
        
        if seconds <= totalSeconds {
            seconds += 50
            let progressValue:Float = Float(totalSeconds) / Float(seconds)
            progressBar.setProgress(progressValue, animated: true)
           print("\(progressValue) in process")
        } else {
            timer.invalidate()
            labelTitle.text = "done"
            playSound()
        }
        
    }
    
    func playSound(){
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    
    
}
