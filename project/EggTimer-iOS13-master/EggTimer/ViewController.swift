import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720];
    var player : AVAudioPlayer!
    var timer = Timer();
    var totalTime = 0;
    var secondPassed = 0;
    
    @IBAction func eggClicked(_ sender: UIButton) {
        progressView.setProgress(0, animated: true);
        textLabel.text = "How do you like your eggs?";
        timer.invalidate();
        secondPassed = 0;
        totalTime = 0;
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true);
    }
    
    @objc func updateTimer(){
        if secondPassed < totalTime {
            let percentageProgress = Float(secondPassed) / Float(totalTime);
            progressView.setProgress(percentageProgress, animated: true);
            secondPassed += 1;
        } else {
            timer.invalidate();
            textLabel.text = "done";
            playSound();
        }
    }
    
    func playSound(){
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3");
        player = try! AVAudioPlayer(contentsOf: url!);
        player.play();
    }
    
}
