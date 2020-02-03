# swift-tutorial
회사서 급하게 iOS가 필요하다고 해서 시작한 스터디

20.02.03

- 오늘은 각각의 이미지와 아이콘을 사이즈별로 구하는 방법을 배웠다.
https://appicon.co/

- Xcode의 간단한 interface를 익혔다.

- 이미지 asset 관련 코드

        import UIKit

        class ViewController: UIViewController {
            
            @IBOutlet weak var diceImageView1: UIImageView!
            @IBOutlet weak var diceImageView2: UIImageView!
            
            override func viewDidLoad() {
                super.viewDidLoad()
                
                diceImageView1.image = #imageLiteral(resourceName: "DiceSix");
                diceImageView2.image = #imageLiteral(resourceName: "DiceFour");
                
                diceImageView1.alpha = 0.5;
                
            }


        }
