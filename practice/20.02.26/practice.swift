// 1. Computed Properties
// 	- Double로 Value 받아오기
// 	- Setting 할 때 String으로 만들기 
// 2. CalcButtonPressed
// 	- 받아온 숫자 AC 등 핸들링
// 3. NumButtonPrssed
// 	- 숫자 Stack Handling
// 	- 소수점 핸들링
// 4. MVC Pattern 적용
// 	- tuple로 갑 저장
// 	- AC 등 핸들링
// 	- 계산 핸들링

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var displayLabel: UILabel!0

	var isFinishedTypingNumber: Bool = true

	@IBAction func calcButtonPressed(_ sender: UIButton){
		isFinishedTypingNumber = false
	}

	@IBAction func numButtonPressed(_ sender: UIButton){

		if let numValue: String = sender.currentTitle {

			if isFinishedTypingNumber {
				displayLabel.text = numValue
				isFinishedTypingNumber = false 
			} else {
				displayLabel.text = displayLabel,.text! + numValue 
			}

		}

	}

}


guard let number = Double(displayLabel.text!) else {
	fatalError("Cannot convert display label text to a Double")
}

ceil => 소수점을 없애고 정수부에 1을 더해줌
floor => 소수점을 모두 버림
round => 반올림 

Swift Tuples

import Foundation

let touple1 = ("Angela", 12)
let touple2 = (name: "Angela", age: 12)
let touple3: (name: String, age: Int)

touple1.0  
touple2.name 
touple3.name = "Angela"


/* Swift Advanced concept full source */


Swift Advanced Concept full source 

import UIKit 

class ViewController: UIViewController {

	@IBOutlet weak var displayLabel: UILabel! //UILabel, 계산기 숫자가 들어가는 곳
	private var isFinishedTypingNumber: Bool = true //숫자를 stack하기 위해서 만든 값 
	private var calculator: CalculatorLogic = CalculatorLogic() //계산기 로직을 가지고 있는 class 

	private var displayValue: Double {
		get {
			guard let number = Double(displayLabel.text!) else {
				fatalError("Cannot convert display text to a Double")
			}
			return number 
		} // 값을 가져올 때, Double로 convert할 수 있으면 가져오게 한다.
		set {
			displayLabel.text = String(newValue) //값을 지정할 때 자동으로 String으로 변환시키고 화면에 출력해준다.
		}
	}

	@IBOutlet func calcButtonPressed(_ sender: UIButton){
		isFinishedTypingNumber = true //유저가 % 등의 버튼을 눌렀을 때 true로 변환 시켜준다. 즉 숫자를 다시 stack할 수 있게 한다.
		calculator.setNumber(displayValue)
		if let calcMethod = sender.currentTitle { // + - * / 
			if let result = calculator.calculate(symbol: calcMethod) { //object에서 계산 결과를 가져옴 
				displayValue = result //계산 결과를 가져와서 displayValue에 다시 세팅해준다. set을 호출하여 String으로 변환되여 자동으로 화면에 출력된다.
			}
		}
	}

	@IBOutlet func numButtonPressed(_ sender: UIButton){
		if let numValue: String = sender.currentTitle {
			displayLabel.text = numValue //일단 첫번 째 값을 출력 
			isFinishedTypingNumber = false //값을 false로 줌으로서 stack하도록 한다.
		} else {
			if numValue == "."{ //소수점 핸들링 
				guard let currentDisplayValue = Double(displayLabel.text!) else { //Double 값을 가져옴 
					fatalError("Cannot convert display label text to a Double")
				}
				if isInt: Bool = floor(currentDisplayValue) == currentDisplayValue //floor를 하면 소수점을 날려버리기 때문에 값이 false면 정수가 아니라는 것을 알 수 있다.
				if !isInt {
					return;
				}
			}
			displayLabel.text = displayLabel.text! + numValue 
		}
	}

}

//CalculatorLogic

import Foundation

struct CalculatorLogic {
	
	private var number: Double?
	private var intermediateCalculation : (n1: Double, calcMethod: String)?

	mutating func setNumber(_ number: Double){
		self.number = number 
	}

	mutating func calculate(symbol: String) -> Double? {
		if let n = number {
			switch symbol {
				case "+/-":
					return n * -1
				case "AC":
					return 0
				case "%":
					return n * 0.01
				case "=":
					return performTwoNumCalculation(n2: n)
				default:
					intermediateCalculation = (n1: n, calcMethod: symbol) //+ - * / 등을 쓴다. 
			}
		}
		return nil
	}

	func performTwoNumCalculation(n2: Double) -> Double? {
		if  let n1 = intermediateCalculation?.n1,
			let operation = intermediateCalculation?.calcMethod {
				case "+":
					return n1 + n2 
				case "-":
					return n1 - n2 
				case "x":
					return n1 * n2 
				case "/":
					return n1 / n2 
				default:
					fatalError("The operation passed in does not match any of the cases")
			}
		return nil 
	}

}


//TableView

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	@IBOutlet weak var tableView: UITableView!

	let images = ["image1.jpg", "image2.jpg", "image3.jpg"]

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> {
		return 3 
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "RowCell", for: indexPath) as! RowDTO
		cell.rowLabel.text = "Test"
		cell.rowImage.image = UIImage(named: images[indexPath.row])
		return cell 
	}

	override func viewDidLoad(){
		super.viewDidLoad()
		tableView.delegate = self 
		tableView.dataSource = self 
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 10  //최소값 지정 
	}

}

class RowDTO: UITableViewCell {

	@IBOutlet weak var rowImage: UIImageView!
	@IBOutlet weak var rowLabel: UILabel!

}


//CollectionView 

import UIKit 

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	let items = [ #imageLiteral(resourceName: "background") , #imageLiteral(resourceName: "image7") , #imageLiteral(resourceName: "background2") , #imageLiteral(resourceName: "13450078_290367081302103_5382854634955251492_n") , #imageLiteral(resourceName: "image1") ]
	let collectionView: UICollectionView!	

	override func viewDidLoad(){
		super.viewDidLoad()

		collectionView.dataSource = self 
		collectionView.delegagte = self 

	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return items.count 
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyCollectionCell
		cell.myImage.image = items[indexPath.row]
		return cell 
	}

	//sizeForItemAt, returns CGSize ->  각 셀의 크기를 정해준다.
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = collectionView.frame.width / 3
		return CGSize(width: width, height: width)
	}

	//minimumInteritemSpacingForSectionAt -> CGFloat, 각 row의 간격을 조정해준다. 
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0 
	}

	//minimumLineSpacingForSectionAt -> CGFloat, 각 줄의 간격을 조정해준다 
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0 
	}

}


//ScrollView

//일단 ScrollView를 Storyboard에 등록해준 후에...

import UIKit 

class ViewController: UIViewController {

	//ViewPager
	@IBOutlet weak var scrollView: UIScrollView! 

	override func viewDidLoad() {
		super.viewDidLoad()

		let images = [#imageLiteral(resourceName: "image6"), #imageLiteral(resourceName: "background"), #imageLiteral(resourceName: "image5")]

		for i in 0..<images.count {
			let imageView = UIImageView //ImageView 선언 
			imageView.image = images[i] //이미지 붙여주기
			imageView.contentMode = .scaleAspectFit //이미지가 비율을 맞추면서 늘어남

			let xPosition = self.view.frame.width * CGFloat(i) //0, 0 - 100, 0 - 200, 0 

			imageView.frame = CGRect(x: xPosition, y: 0, width: self.view.frame.width, height: self.view.frame.height) //CGRect은 좌표를 의미함, 이미지를 배치할 부분 x
			scrollView.contentSize.width = self.view.frame.width * CGFloat(1 + i)
			scrollView.addSubview(imageView)

		}

	}

}

// 카카오톡 프로파일 메시지

import UIKit 

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	var Users = [UserDTO]() //데이터타입
	@IBOutlet weak var tableView: UITableView!

	override func viewDidLoad() {
		super.viewDidLoad()

		tableView.delegate = self 
		tableView.UITableViewDataSource = self 

		tableView.rowHeight = 80 

		Users.append(UserDTO(imageString: "image1.jpg", name: "신승현", message: "성공하고 싶다"))
		Users.append(UserDTO(imageString: "image1.jpg", name: "신승현", message: "성공하고 싶다"))
		Users.append(UserDTO(imageString: "image1.jpg", name: "신승현", message: "성공하고 싶다"))

	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		let cell = tableView.dequeueReusableCell(withIdentifier: "RowCell", for: indexPath) as! CustomCell
		cell.profileImage.image = UIImage(named: Users[indexPath.row].imageString)
		cell.profileImage.layout.cornerRadius = (cell.profileImage.frame.width) / 2 
		cell.profileImage.layer.masksToBounds = true 

		cell.profileName.text = Users[indexPath.row].name
        cell.profileMessage.text = Users[indexPath.row].message

		//Use Constraints programatically
		cell.bubbleSpeech.translatesAutosizingMaskIntoConstraints = false 
		cell.bubbleSpeech.leftAnchor.constraint(equalTo: cell.profileMessage.leftAnchor, constants: -10).isActive = true 
		cell.bubbleSpeech.topAnchor.constraint(equalTo: cell.profileMessage.topAnchor, constants: -10).isActive = true 
		cell.bubbleSpeech.rightAnchor.constraint(equalTo: cell.profileMessage.rightAnchor, constants: 10).isActive = true 
		cell.bubbleSpeech.bottomAnchor.constraint(equalTo: cell.profileMessage.bottomAnchor, constants: 10).isActive = true 
		cell.bubbleSpeech.layer.cornerRadius = 10 
		cell.bubbleSpeech.layer.masksToBounds = true 
		
		
		return cell 
	}

}

class CustomCell: UITableViewCell {

	@IBOutlet weak var profileImage: UIImageView! 
	@IBOutlet weak var profileName: UILabel!
	@IBOutlet weak var profileMessage: UILabel! 
	@IBOutlet weak var bubbleSpeech: UIView!

}


//TabBar Animation 

import UIKit

//Implemenets Delegate `NSObject, `UITabBarControllerDelegate`
class AnimUtils: NSObject, UITabBarControllerDelegate {

	//get the function which returns `UIViewControllerAnimatedTransitioning`
	 func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return ScrollingAnim(tabBarController: tabBarController) //tabBarController를 넘기는 Object를 부른다.
	 }

}

class ScrollingAnim: NSObject, UIViewControllerAnimatedTransitioning {

	var tabBarController: UITabBarController!
	
	//추가적으로 fromInde와 transitionContext 값을 가져온다
	var fromIndex: Int = 0 
	weak var transitionContext: UIViewControllerContextTransitioning? 

	//transitionDuration => transitio 시간을 정해줌 
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

	//실제로 animation을 적용할 `animateTransition`
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

		self.transitionContext = transitionContext
		let containerView: UIView = transitionContext.containerView 

		//원래 뷰
		let fromView = transitionContext.ViewController(forKey: UITransitionContextViewControllerKey.from)
		//추가 될 뷰
		let toView = transitionContext.ViewController(forKey: UITransitionContextViewControllerKey.to)

		//적용
		containerView.addSubview(toView!.view)
		var width = toView?.view.bounds.width 



	}

}




//NavigationController as! Viewcontroller
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	let destinationNavigation = segue.destination as! UINavigationController 
	let destionationViewController = destinationNavigation.topViewController as! ViewController 
	
}






// Privacy 

/*
info.plist 에서
Privacy - Camera Usage Description,
Privacy - Photo Library Additions Usage Description 
추가 
*/

import UIKit 
//권한을 확인해주기 위해서 `AVFoundation, Photos`가져오기
import AVFoundation
import Photos 

class ViewController: UIViewcontroller, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	override func viewDidLoad(){

		let cameraStatus = AVCaptureDevice.authorizationStatus(for: AVMedia.video)
		if cameraStatus == .authorized {
			//승인 
		} else if cameraStatus == .restricted {
			//일부 권한 
		} else if cameraStatus == .notDetermined {
			//아직 물어보지 않음 
		} else {
			DispatchQueue.main.async {
				let alert = UIAlertController(title: "권한", message: "카메라 권한을 받아오지 못했습니다.", .alert)
			}
		}

		
	}

	@IBAction func camera(_ sender: UIButton){
		let imagePicker = UIImagePickerController()
		imagePicker.delegate = self 
		imagePicker.sourceType = UIImagePickerController.sourceType.camera 
		self.present(imagePicker, animated: true, completion: nil)
	}

	@IBAction func album(_ sender: UIButton){
		let imagePicker = UIImagePickerController()
		imagePicker.delegate = self 
		imagePicker.sourceType = UIImagePickerController.sourceType.photoLibrary 
		imagePicker.allowsEditing = true 
		self.present(imagePicker, animated: true, completion: nil)
	}


}



//이미지 찍어서 저장

func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
	
	if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
		imageView.contentMode = .scaleAspectFit
		imageView.image = pickedImage
	}
	
	dismiss(animated: true, completion: nil)
	
}

@IBAction func savePhoto(_ sender: UIButton) {
	UIImageWriteToSavedPhotosAlbum(self.imageView.image!, nil, nil, nil)
}



@IBAction func notificationButton(_ sender: UIButton){
	let content = UNMutableNotificationContent()
	content.title = NSString.localizedUserNotificationString(forKey: "Hello!", arguments: nil)
	content.body = NSString.localizedUserNotificationString(forKey: "Hello_message", arguments: nil)
	content.sound = UNNotificationSound.default 
	let trigger = UNTimeIntervalNotificationTrigger(TimeInterval: 1, repeats: false)
	let request = UNNotificationRequest(identifer: "FiveSecond", content: content, trigger: trigger)
	let center = UNUserNotificationCenter.current() 
	center.add(request, widthCompletionHandler: nil)

}