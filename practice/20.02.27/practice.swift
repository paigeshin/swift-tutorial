//카메라 및 앨범 열기 sample code

/*

먼저 info.plist로 가서 값을 추가한다
Privacy - Camera Usage Description
Privacy - Photo Library Additions Usage Description

*/

import UIKit
//권한 확인
import AVFoundation
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerdelegate {

    override func viewDidLoad(){
        super.viewDidLoad()

        let camearaStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)

        if camearaStatus == .authorized {
            //승인
        } else if cameraStauts == .restricted {
            //일부 권한만 허용함
        } else if camearaStatus == .notDetermined {
            //아직 물어보지 않음 
        } else if camearaStatus == .denied {
            //거절 당함
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "권한", message: "카메라 권한을 받아올 수 없습니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }

        let albumStatus = PHPhotoLibrary.authorizationStatus()

        if albumStatus == .authorized {
            //승인 
        } else if albumStatus == .restricted {
            //일부 권한만 승인
        } else if albumStatus == .notDetermined {
            //아직 물어보지 않음
        } else if albumStatus == .denied {
            //거절 당함
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "권한", message: "앨범 권한을 받아올 수 없습니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
 

    }

    @IBAction func camera(_ sender: UIButton){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self 
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        self.present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func album(_ sender: UIButton){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self 
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary 
        imagePicker.allowsEditing = true 
        self.present(imagePicker, animated: true, completion: nil)
    }

    //사진 세팅, delegate 함수를 가져온다.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        dismiss(animted: true, completion: nil)
    }

    //사진 저장
    @IBAction func savePhoto(_ sender: UIButton){
        UIImageWriteToSavedPhotosAlbum(self.imageView.image!, nil, nil, nil)
    }

}






// iOS Notification (without Server)

//일단 AppDelegate.swift 위에서 코드 작성

import UserNotifications

class AppDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.launchOptions: Any]?) -> Bool {

        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in

        }

        return true 
    }

}

//ViewController.swift 파일에서...
import UIKit 
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad(){
        super.viewDidLoad()

        let answer_1 = UNNotificationAction(identifier: "Good", title: "Lecture was great", options: [.forground])
        let answer_2 = UNNotificationAction(identifier: "Not Good", title: "Lecture quality was poor", options: [.forground])
        let category = UNNotificationCategory(identifier: "SelectBox", actions: [answer_1, answer_2], intentIentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])

        UNUserNotificationCenter.current().delegate = self 
    }

    @IBAction func notificationButtonPressed(_ sender: UIButton){
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Hello!", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Hello_message", arguments: nil)
        content.sound = UNNotificationSound.default 
        content.categoryIdentifier = "SelectBox"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let center = UNUserNotificationCenter.current()
        let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger)
        center.add(request, withCompletionHandler: nil)
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completitionHandler: @escaping (UNNotificationPresenetationOptions) -> Void) {
        completionHandlker([.alert, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    
    switch response.actionIdentifier {
        case "Good":
            label.text = "Lecture was Good"
        case "Not Good":
            label.text = "Lecture wasn't that bad"
        default:
            break
    }
        
    }

}


Map kit 

import UIKit 
import MapKit 

class ViewController: UIViewController {

    @IBOutlet weak var mapKitView: MKMapView! 

    override func viewDidLoad

}