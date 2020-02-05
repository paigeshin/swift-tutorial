import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func keyPressed(_ sender: UIButton) {
        
        playSound(note: sender.currentTitle!)
        print("\(sender.currentTitle!) is played")
        sender.imageView?.backgroundColor?.withAlphaComponent(0.5)
        
    }
    
    func playSound(note: String){
        let url = Bundle.main.url(forResource: note, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    
}

