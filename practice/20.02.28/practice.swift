//카메라 및 앨범 열기

//info.plist로 가서 권한을 준다.
//Privacy - Camera Usage Description
//Privacy - Photo Library Additions Usage Description

//Implement two essential Protocols
//UIImagePickerControllerDelegate, UINavigationControllerDelegate

//Code

import UIKit 
//권한 확인
import AVFoundation
import Photos 

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad(){
        super.viewDidLoad()
        
        let cameraStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)

        if cameraStatus == .authorized {
            //승인
        } else if cameraStatus == .restricted {
            //일부 권한 
        } else if cameraStatus == .notDetermined {
            //아직 물어보지 않음 
        } else if cameraStatus == .denied {
            //거절 당함 
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "권한", message: "카메라 권한을 받아오지 못했습니다.", prefferedStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }

        let albumStatus = PHPhotoLibrary.authorizationStatus()

        if albumStatus == .authorized {
            //승인
        } else if albumStatus == .restricted {
            //일부 권한 
        } else if albumStatus == .notDetermined {
            //아직 물어보지 않음
        } else if albumStatus == .denied {
            //거절 당함
            DispatchQueue.main.async {
                let alert = UIAlertActionController(title: "권한", message: "앨범 권한을 받아오지 못했습니다.", prefferedStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }



    }

    @IBAction func camera(_ sender: UIButton){
        let imagePikcer = UIImagePickerController()
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

    //사진 붙여주기 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){

        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }

        dismiss(animated: true, completion: nil)

    }

    //사진 저장
    @IBAction func savePhoto(_ sender: UIButton){
        UIImageWriteToSavedPhotosAlbum(self.imageView.image!, nil, nil, nil)
    }

}


//언어 번역한 것 가져와서 쓰기 

@IBAction func notificationButton(_ sender: UIButton){

    let content = UNMutableNotificationContent()
    content.title = NSString.localizedUserNotificationString(forKey: "Hello", arguments: nil)  //forKey가 key 값임. Localizable.string에 여러 언어 번역본이 마련되어 있음.
    content.body = NSString.localizedUserNotificationString(forKey: "Hello_message", arguments: nil)
    content.sound = UNNotificationSound.default 
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
    let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger)
    let center = UNNotificationCenter.current()
    center.add(request, withCompletionHandler: nil)


}
//iOS local notification 

//App Delegate 기본 세팅 

import UserNotifications 

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    //Initialize UNUserNotificationCenter 
    let center = UNUserNotificationCenter.current()
    center.requestAuthroization(options: [.alert, .sound]) {(granted, error) in 
    
    } 

    return true 

}


//in ViewController 

import UserNotifications 

class ViewController: UIViewCOntroller, UNUserNotificationCenterDelegate {

    override func viewDidLoad(){
        super.viewDidLoad()

        //Notification에 버튼 추가하기 ex) 설문조사 같은 느낌
        let answer_1 = UNNotificationAction(identifier: "Good", title: "Lecture was great", options: [.foreground])
        let answer_2 = UNNotificaitonAction(identifier: "Fine", title: "Lecture was just fine", options: [.foreground])
        let category = UNNotificationCategory(identifier: "SelectBox", actions: [answer_1, answer_2], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])

        UNUserNotificationCenter.current().delegate = self 
    }

    @IBAction func notificationButton(_ sender: UIButton) {
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Hello", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Hello_message_body", arguments: nil)
        content.categoryIdentifier = "SelectBox"
        //Deliver the notification in five seconds 
        content.sound = UNNotificationSound.default 
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
    }

    //Notificaiton이 올 때 소리가 나오게 하려면 delegate function을 받아와야 한다. 
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
        completionHandler([.alert, .sound])
    }

}



//Firebase Push Message 코드 삽입 

import UIKit 
import Firebase 
import UserNotifications 

@UIApplicationMain 
class AppDelegate: UIResponder, UIApplicationDelegate {

    let gcmMessageIdKey = "gcm.message.id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        //Register for remote notifications 
        if #availabe(iOS 10.0, *) {
            //For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self 
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthroization(
                options: authOptions,
                completionHandler: {_, _ in}
            ) 
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }

        //set the messaging delegate => To receive registration tokens
        Messaging.messaging().delegate = self  //This is to receive registration tokens 

        application.registerForRemoteNotifications()
        FirebaseApp.configure()
        return true 
    }

        // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}



//Receive Message 
@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {

    //When your app is in the background, iOS directs messages with the `notification` key to the system tray.
    //To be notified whenver the token is updated.
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String){
        print("Firebase registration token: \(fcmToken)")

        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        //TODO: If necessary send token to application server
        //Note: This callback is fired at eacth app startup and whenever a new token is generated.
    }

    //메세지 실제로 받는 것
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage){
        print("Message Data: \(remoteMessage.appData)")
    }
    
}

//Handle messages with method swizzling disabled
@availabe(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {

    //Receive displayed notifications for iOS 10 devices
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo 
        if let messageID = userInfo[gcmMessageIdKey] {
            print("MessageID: \(messageID)")
        }
        print(userInfo)
        completionHandler()
    }


    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping() -> Void){
        let userInfo = response.notification.request.content.userInfo 
        if let messageID = userInfop[gcmMessageIdKey]{
            print("MessageID: \(messageID)")
        }
        print(userInfo)
        completionHandler()
    }

}

//MAP KIT
import UIKit 
import MapKit 

class ViewController: UIViewController {

    @IBLOutlet weak var mapKitView: MKMapView!
    //권한 요청을 위해.. 
    let locationManager = CLLocationManager() 

    override func viewDidLoad(){
        super.viewDidLoad()

        //점을 찍을 위치 
        let location = CLLocationCoordinate2D(latitude: 37.392448, longitude: 126.344234)

        //화면 찍는 부분과 description 추가
        let annotaion = MKPointAnnotaion()
        annotaion.coordinate = location 
        annotation.title = "Central Park"
        annotation.subtitle = "공원"

        //확대하는 코드 
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location, span: span) //지역에 location과 span 추가
        mapKitView.addAnnotation(annotation)

        locationManager.requestWhenInUseAuthorization()
        mapKitView.showUserLocation = true 

    }

}

//Firebase Auth Listener

Auth.auth().addStateDidChangeListener { (user, error) in 
    if user != nil {
        self.performSegue(withIdentifier: "Home", sender: self)
    }
}

func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

    let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage  //반드시 UIImage로 parsing 해야함 . 

    if let data = pickedImage.pngData() {
        
        //저장할 파일의 이름을 정해줌 
        let fileImageName = "\(String(describing: Auth.auth().currentUser?.uid))" + "\(Int(Date.timeIntervalBetween1970AndReferenceDate * 1000)).jpg"

        let ref = Storage
            .storage()
            .reference()
            .child("ios_images")
            .child(fileImageName)

            ref.putData(data, metadata: nil) { (metadata, error) in 
                if error != nil {
                    
                } else {
                    guard let metadata = metadata else {return}
                }
            }
            dismiss(animated: true, completion: nil)
    }

}


Database.database().reference().child("users").setValue([
    "userId": Auth.auth().currentUser?.email,
    "uid": Auth.auth().currentUser?.uid,
    "subject": self.subject!.text!,
    "explanation": self.explanation.text!,
    "imagerl": downloadURL
])
