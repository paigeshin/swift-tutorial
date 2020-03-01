# swift-tutorial
회사서 급하게 iOS가 필요하다고 해서 시작한 스터디

2020.03.01

🔵 Remote Config

- app을 원격으로 조정할 때, 예를들어 서버를 조정한다던가..

    관련 doucment

    [https://firebase.google.com/docs/remote-config/use-config-ios](https://firebase.google.com/docs/remote-config/use-config-ios)

    1. pod 설치 

        pod 'Firebase/Core'
        pod 'Firebase/RemoteConfig'

     2.  remote server에 parameter 등록

    ![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/7ebcd05b-6325-4f4a-af98-88397609c168/Screen_Shot_2020-03-01_at_14.12.27.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/7ebcd05b-6325-4f4a-af98-88397609c168/Screen_Shot_2020-03-01_at_14.12.27.png)

    3. create plist file to store data

    ![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/7d09a112-9c9c-4132-b7bb-4accfccf9a26/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/7d09a112-9c9c-4132-b7bb-4accfccf9a26/Untitled.png)

     

    4.  installation

        var remoteConfig: RemoteConfig!
            
            override func viewDidLoad() {
                super.viewDidLoad()
                // Do any additional setup after loading the view.
                
                remoteConfig = RemoteConfig.remoteConfig()
                remoteConfig.setDefaults(fromPlist: "FirebaseRemoteConfig")
                
                self.fetchConfig()
                DispatchQueue.main.async {
                 
                    self.displayMessage()
                }
                
            }

     5.  set the message

        func displayMessage(){
                let message = remoteConfig["welcome_message"].stringValue
                let caps = remoteConfig["welcome_message_caps"].boolValue
                let color = remoteConfig["backgroundColor"].numberValue
                
                if caps {
                    let alert = UIAlertController(title: "공지사항", message: message, preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .default) { (action) in
                        exit(0)
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
                if color == 1 {
                    self.view.backgroundColor = UIColor.black
                }
            }

     6.  fetch config

        func fetchConfig() {
                
                let remoteConfigSettings = RemoteConfigSettings()
                remoteConfig.configSettings = remoteConfigSettings
                
                remoteConfig.fetch(withExpirationDuration: 3600) { (state, error) in
                    
                    if state == .success {
                        self.remoteConfig.activate { (error) in
                            if error != nil {
                                self.displayMessage()
                            }
                        }
                    }
                    
                }
                
            }

    7.  full code

        //
        //  ViewController.swift
        //  remote_config
        //
        //  Created by shin seunghyun on 2020/03/01.
        //  Copyright © 2020 shin seunghyun. All rights reserved.
        //
        
        import UIKit
        import Firebase
        
        
        class ViewController: UIViewController {
            
            var remoteConfig: RemoteConfig!
            
            override func viewDidLoad() {
                super.viewDidLoad()
                // Do any additional setup after loading the view.
                
                remoteConfig = RemoteConfig.remoteConfig()
                remoteConfig.setDefaults(fromPlist: "FirebaseRemoteConfig")
                
                self.fetchConfig()
                DispatchQueue.main.async {
                 
                    self.displayMessage()
                }
                
            }
            
            func fetchConfig() {
                
                let remoteConfigSettings = RemoteConfigSettings()
                remoteConfig.configSettings = remoteConfigSettings
                
                remoteConfig.fetch(withExpirationDuration: 3600) { (state, error) in
                    
                    if state == .success {
                        self.remoteConfig.activate { (error) in
                            if error != nil {
                                self.displayMessage()
                            }
                        }
                    }
                    
                }
                
            }
            
            func displayMessage(){
                let message = remoteConfig["welcome_message"].stringValue
                let caps = remoteConfig["welcome_message_caps"].boolValue
                let color = remoteConfig["backgroundColor"].numberValue
                
                if caps {
                    let alert = UIAlertController(title: "공지사항", message: message, preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .default) { (action) in
                        exit(0)
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
                if color == 1 {
                    self.view.backgroundColor = UIColor.black
                }
            }
            
            
        }



2020.02.28

### 🔵 구글 로그인

[https://firebase.google.com/docs/auth/ios/google-signin](https://firebase.google.com/docs/auth/ios/google-signin) 

⇒ 관련 문서

- GoogleService-Info.plist 에서 REVERSED_CLIENTED_ID 를 복사해준다.

`com.googleusercontent.apps.858094909588-21o045pjmm1l16o5vis3agm8ipab2p8o`

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/5d9c316f-3893-4ee8-9f6e-e880c219f139/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/5d9c316f-3893-4ee8-9f6e-e880c219f139/Untitled.png)

- App 정보 창에서 `Info` Tab에 들어가서 URL Types을 추가해준다

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b286383b-36e9-4111-82ca-ca13cccccee6/Screen_Shot_2020-02-27_at_15.13.15.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b286383b-36e9-4111-82ca-ca13cccccee6/Screen_Shot_2020-02-27_at_15.13.15.png)

- AppDelegate에 코드 추가

        //
        //  AppDelegate.swift
        //  GoogleAuth
        //
        //  Created by shin seunghyun on 2020/02/27.
        //  Copyright © 2020 shin seunghyun. All rights reserved.
        //
        
        import UIKit
        import Firebase
        import GoogleSignIn
        import FirebaseAuth
        
        @UIApplicationMain
        class AppDelegate: UIResponder, UIApplicationDelegate {
            
            
            func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                // Override point for customization after application launch.
                FirebaseApp.configure()
                GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
                GIDSignIn.sharedInstance().delegate = self
                return true
            }
            
            @available(iOS 9.0, *)
            func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
              -> Bool {
              return GIDSignIn.sharedInstance().handle(url)
            }
            
            func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
                return GIDSignIn.sharedInstance().handle(url)
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
        
        extension AppDelegate: GIDSignInDelegate {
            func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
                
                if let error = error {
                  print(error)
                  return
                }
            
                guard let authentication = user.authentication else { return }
                let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                                  accessToken: authentication.accessToken)
                print(credential)
            }
            
            func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
                // Perform any operations when the user disconnects from app here.
                // ...
            }
        }

- View를 지정해주고 Custom Class를 넣어준다

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/77fa312c-7553-4c38-92e2-009b7cea5224/Screen_Shot_2020-02-27_at_15.28.14.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/77fa312c-7553-4c38-92e2-009b7cea5224/Screen_Shot_2020-02-27_at_15.28.14.png)

- MainViewController

    //
    //  ViewController.swift
    //  GoogleAuth
    //
    //  Created by shin seunghyun on 2020/02/27.
    //  Copyright © 2020 shin seunghyun. All rights reserved.
    //
    
    import UIKit
    import Firebase
    import GoogleSignIn
    import FirebaseAuth
        
        class ViewController: UIViewController {
            
            override func viewDidLoad() {
                super.viewDidLoad()
                // Do any additional setup after loading the view.
                GIDSignIn.sharedInstance()?.presentingViewController = self
                GIDSignIn.sharedInstance().signIn() //이렇게 해주면 이미 로그인 됬을 시에는 바로 넘어가게 설정 가능하다.
            }
            
            @IBAction func googleSinginButtonPressed(_ sender: GIDSignInButton) {
                GIDSignIn.sharedInstance().signIn()
            }
            
        
            
        }

⇒ 이렇게 하면 끝이 난다'


🔵 Firebase Email Login 
- TextField 디자인

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/63b2d032-fe44-4524-9822-4a4a00ec914a/Screen_Shot_2020-02-27_at_16.03.58.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/63b2d032-fe44-4524-9822-4a4a00ec914a/Screen_Shot_2020-02-27_at_16.03.58.png)

⇒ Attributed를 누르면 여러가지 customizing이 가능해짐

- button 디자인

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/29cf95cb-e23c-43b2-b053-d2d5fdfeeccb/Screen_Shot_2020-02-27_at_16.04.36.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/29cf95cb-e23c-43b2-b053-d2d5fdfeeccb/Screen_Shot_2020-02-27_at_16.04.36.png)

⇒ Key, Value 값의 형태로 값을 지정해줄 수 있다.  현재는 `cornerRadius` 값을 넣어줬다. 

    @IBAction func loginButtonPressed(_ sender: UIButton) {
            
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
                
                if(error != nil){return}
                
                let alert = UIAlertController(title: "알림", message: "회원가입완료", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            
        }


🔵 Firebase Login Listener

- 아래 코드를 삽입하면 유저가 이미 있으면 그냥 앞 화면으로 넘어가게 한다

        Auth.auth().addStateDidChangeListener { (user, error) in
              if user != nil {
                  self.performSegue(withIdentifier: "Home", sender: self)
              }
        }

- 전체 코드

        //
        //  ViewController.swift
        //  GoogleAuth
        //
        //  Created by shin seunghyun on 2020/02/27.
        //  Copyright © 2020 shin seunghyun. All rights reserved.
        //
        
        import UIKit
        import GoogleSignIn
        import FirebaseAuth
        
        class ViewController: UIViewController {
            
            @IBOutlet weak var email: UITextField!
            @IBOutlet weak var password: UITextField!
            
            override func viewDidLoad() {
                super.viewDidLoad()
                // Do any additional setup after loading the view.
                GIDSignIn.sharedInstance()?.presentingViewController = self
                GIDSignIn.sharedInstance().signIn() //이미 로그인 됬을 시에는 바로 넘어가게 설정 가능하다.
                
                Auth.auth().addStateDidChangeListener { (user, error) in
                    if user != nil {
                        self.performSegue(withIdentifier: "Home", sender: self)
                    }
                }
                
            }
            
            @IBAction func googleSinginButtonPressed(_ sender: GIDSignInButton) {
                GIDSignIn.sharedInstance().signIn()
                
                
            }
            
            @IBAction func loginButtonPressed(_ sender: UIButton) {
                Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
                    if(error != nil){
                        Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!) { (user, error) in
                            self.performSegue(withIdentifier: "Home", sender: self)
                        }
                        return
                    } else {
                        
                        let alert = UIAlertController(title: "알림", message: "회원가입완료", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
        
                }
            }
            
            
        }

🔵 Firebase File Upload

- 먼저 앨범을 열어준다

    @IBAction func profileUpload(_ sender: UIButton) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }

- 앨범을 열어준 후에 사진을 저장

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            
            let pickedImage =  info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            
            if let data = pickedImage.pngData() {
                let fileImageName = "\(String(describing: Auth.auth().currentUser?.uid))" + "\(Int(Date.timeIntervalBetween1970AndReferenceDate * 1000)).jpg"
                
                //FireStore 선언
                let ref = Storage
                    .storage()
                    .reference()
                    .child("ios_images")
                    .child(fileImageName)
                
                ref.putData(data, metadata: nil) { (metadata, error) in
                    if(error != nil){
                        
                    } else {
                        guard let metadata = metadata else { return }
                    }
                }
            }
            dismiss(animated: true, completion: nil)
            
        }

1. imagePicker delegate method 중에 `didFinishPickingMediaWithInfo` 을 고른다 
2. `pngData()` 를 이용해서 `Data` 타입으로 바꾸어줌 
3. Reference Storage를 instatiate
4. `ref.putData` 호출 

- 전체 코드

    //
    //  UserController.swift
    //  GoogleAuth
    //
    //  Created by shin seunghyun on 2020/02/27.
    //  Copyright © 2020 shin seunghyun. All rights reserved.
    //
    
    import UIKit
    import FirebaseAuth
    import FirebaseStorage
    
    class UserController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        }
        
        
        @IBAction func logout(_ sender: UIButton) {
            
            do {
                try Auth.auth().signOut()
            } catch {
                print(error.localizedDescription)
            }
            dismiss(animated: true, completion: nil)
            
        }
        
        @IBAction func profileUpload(_ sender: UIButton) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            
            let pickedImage =  info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            
            if let data = pickedImage.pngData() {
                let fileImageName = "\(String(describing: Auth.auth().currentUser?.uid))" + "\(Int(Date.timeIntervalBetween1970AndReferenceDate * 1000)).jpg"
                
                //FireStore 선언
                let ref = Storage
                    .storage()
                    .reference()
                    .child("ios_images")
                    .child(fileImageName)
                
                ref.putData(data, metadata: nil) { (metadata, error) in
                    if(error != nil){
                        
                    } else {
                        guard let metadata = metadata else { return }
                    }
                }
            }
            dismiss(animated: true, completion: nil)
            
        }
        
    }

🔵 Firebase Database

- 실제 데이터 베이스 코드 부분

    //데이터를 실제로 데이터 베이스에 보내주는 부분
    Database.database().reference().child("users").setValue([
        "userId": Auth.auth().currentUser?.email,
        "uid": Auth.auth().currentUser?.uid,
        "subject": self.subject.text!,
        "explanation": self.explanation.text!,
        "imageUrl": downloadURL
    ])

⇒ 먼저 FirebaseDatabase 를 import 

⇒ `setValue( Dictionary )` , parameter로 class가 들어가도 된다  

- 전체 코드

    func upload(pickedImage: UIImage){
            
            if let data = pickedImage.pngData() {
                
                let fileImageName = "\(String(describing: Auth.auth().currentUser?.uid))" + "\(Int(Date.timeIntervalBetween1970AndReferenceDate * 1000)).jpg"
                
                //FireStore 선언
                let ref = Storage
                    .storage()
                    .reference()
                    .child("ios_images")
                    .child(fileImageName)
                
                ref.putData(data, metadata: nil) { (metadata, error) in
                    if(error != nil){
                        
                    } else {
                        ref.downloadURL { (url, error) in
                            if let downloadURL = url?.absoluteString {
                                
                                //데이터를 실제로 데이터 베이스에 보내주는 부분
                                Database.database().reference().child("users").setValue([
                                    "userId": Auth.auth().currentUser?.email,
                                    "uid": Auth.auth().currentUser?.uid,
                                    "subject": self.subject.text!,
                                    "explanation": self.explanation.text!,
                                    "imageUrl": downloadURL
                                ])
                            }
                            
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
            
        }

🔵 Firebase Database Retrieve data

- UserDTO

❗️NSObject를 상속해야함.

    //
    //  UserDTO.swift
    //  GoogleAuth
    //
    //  Created by shin seunghyun on 2020/02/29.
    //  Copyright © 2020 shin seunghyun. All rights reserved.
    //
    
    import UIKit
    
    class UserDTO: NSObject {
        
        var uid: String?
        var userId: String?
        var subject: String?
        var explanation: String?
        var imageUrl: String?
        
    }

- Data Retrieve

    Database.database().reference().child("users").observe(DataEventType.value) { (snapshot) in
                
                print(snapshot)
                self.array.removeAll()
                
                for child in snapshot.children {
                    let fChild = child as! DataSnapshot
                    let dictionary = fChild.value as! [String: Any]
                    //Mapping
                    let userDTO = UserDTO()
                    userDTO.explanation = dictionary["explanation"] as? String
                    userDTO.subject = dictionary["subject"] as? String
                    userDTO.imageUrl = dictionary["imageUrl"] as? String 
                    
                    
                    self.array.append(userDTO)
                }
                
                self.collectionView.reloadData()
                
            }

- Full Code

    //
    //  HomeController.swift
    //  GoogleAuth
    //
    //  Created by shin seunghyun on 2020/02/27.
    //  Copyright © 2020 shin seunghyun. All rights reserved.
    //
    
    import UIKit
    import FirebaseAuth
    import FirebaseDatabase
    
    class HomeController: UIViewController {
        
        var array: [UserDTO] = []
        var uidKey: [String] = []
        
        @IBOutlet weak var collectionView: UICollectionView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
    
    
            Database.database().reference().child("users").observe(DataEventType.value) { (snapshot) in
                
                print(snapshot)
                self.array.removeAll()
                
                for child in snapshot.children {
                    let fChild = child as! DataSnapshot
                    let dictionary = fChild.value as! [String: Any]
                    //Mapping
                    let userDTO = UserDTO()
                    userDTO.explanation = dictionary["explanation"] as? String
                    userDTO.subject = dictionary["subject"] as? String
                    userDTO.imageUrl = dictionary["imageUrl"] as? String 
                    
                    
                    self.array.append(userDTO)
                }
                
                self.collectionView.reloadData()
                
            }
            // Do any additional setup after loading the view.
        }
        
    
        /*
        // MARK: - Navigation
    
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */
    
    }
    
    extension HomeController : UICollectionViewDataSource, UICollectionViewDelegate {
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return array.count;
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RowCell", for: indexPath) as! CustomCell         
            cell.subject.text = array[indexPath.row].subject
            cell.explanation.text = array[indexPath.row].explanation
    
            let data = try? Data(contentsOf: URL(string: array[indexPath.row].imageUrl!)!)
            cell.imageView.image = UIImage(data: data!)
            
    
            
            return cell
        }
        
        
    }
    
    class CustomCell : UICollectionViewCell {
        
        @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var subject: UILabel!
        @IBOutlet weak var explanation: UILabel!
        
    }

❗️iOS에서는 glide 같은 library를 쓰지 않아도 이미지를 가져올 수 있다. 

Data(contentsOf: URL(string: array[indexPath.row].imageUrl!)!)


🔵 Firebase Transaction, Like Button
# Save data as transactions

When working with data that could be corrupted by concurrent modifications, such as incremental counters, you can use a [transaction operation](https://firebase.google.com/docs/reference/ios/firebasedatabase/interface_f_i_r_database_reference#a796bff455159479a44b225eeaa2ba9d6). You give this operation two arguments: an update function and an optional completion callback. The update function takes the current state of the data as an argument and returns the new desired state you would like to write.

For instance, in the example social blogging app, you could allow users to star and unstar posts and keep track of how many stars a post has received as follows:

    ref.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
      if var post = currentData.value as? [String : AnyObject], let uid = Auth.auth().currentUser?.uid {
        var stars: Dictionary<String, Bool>
        stars = post["stars"] as? [String : Bool] ?? [:]
        var starCount = post["starCount"] as? Int ?? 0
        if let _ = stars[uid] {
          // Unstar the post and remove self from stars
          starCount -= 1
          stars.removeValue(forKey: uid)
        } else {
          // Star the post and add self to stars
          starCount += 1
          stars[uid] = true
        }
        post["starCount"] = starCount as AnyObject?
        post["stars"] = stars as AnyObject?
    
        // Set value and report transaction success
        currentData.value = post
    
        return TransactionResult.success(withValue: currentData)
      }
      return TransactionResult.success(withValue: currentData)
    }) { (error, committed, snapshot) in
      if let error = error {
        print(error.localizedDescription)
      }
    }

Using a transaction prevents star counts from being incorrect if multiple users star the same post at the same time or the client had stale data. The value contained in the **`FIRMutableData`** class is initially the client's last known value for the path, or **`nil`** if there is none. The server compares the initial value against it's current value and accepts the transaction if the values match, or rejects it. If the transaction is rejected, the server returns the current value to the client, which runs the transaction again with the updated value. This repeats until the transaction is accepted or too many attempts have been made.

**Note:** Because **`runTransactionBlock:andCompletionBlock:`** is called multiple times, it must be able to handle **`nil`** data. Even if there is existing data in your remote database, it may not be locally cached when the transaction function is run, resulting in **`nil`** for the initial value.

    //
    //  HomeController.swift
    //  GoogleAuth
    //
    //  Created by shin seunghyun on 2020/02/27.
    //  Copyright © 2020 shin seunghyun. All rights reserved.
    //
    
    import UIKit
    import FirebaseAuth
    import FirebaseDatabase
    
    class HomeController: UIViewController {
        
        var uidKey: [String] = []
        var array: [UserDTO] = []
        
        
        @IBOutlet weak var collectionView: UICollectionView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            Database.database().reference().child("users").observeSingleEvent(of: DataEventType.value) { (snapshot) in
                
                print(snapshot)
                self.array.removeAll()
                self.uidKey.removeAll()
                
                for child in snapshot.children {
                    let fChild = child as! DataSnapshot
                    let dictionary = fChild.value as! [String: Any]
                    //Mapping
                    let userDTO = UserDTO()
                    
                    userDTO.explanation = dictionary["explanation"] as? String
                    userDTO.subject = dictionary["subject"] as? String
                    userDTO.imageUrl = dictionary["imageUrl"] as? String
                    userDTO.stars = dictionary["stars"] as? [String: Bool]
                    
                    let uidKey = fChild.key
                    
                    self.array.append(userDTO)
                    //자동으로 생성된 key값을 어레이에 담아준다.
                    self.uidKey.append(uidKey)
                }
                
                self.collectionView.reloadData()
                
            }
            // Do any additional setup after loading the view.
        }
        
        
    }
    
    extension HomeController : UICollectionViewDataSource, UICollectionViewDelegate {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return array.count;
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RowCell", for: indexPath) as! CustomCell         
            cell.subject.text = array[indexPath.row].subject
            cell.explanation.text = array[indexPath.row].explanation
            
            let data = try? Data(contentsOf: URL(string: array[indexPath.row].imageUrl!)!)
            cell.imageView.image = UIImage(data: data!)
            
    				//tag를 달아 줄 수 있음 
            cell.startButton.tag = indexPath.row
            cell.startButton.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
            
            //Firebase Database의 post 값이 특정 유저의 uid가 있는지 없는지 체크해준다.
            if let _ = self.array[indexPath.row].stars?[Auth.auth().currentUser!.uid]{
                //좋아요가 클릭도 있을 경우
                cell.startButton.setImage(#imageLiteral(resourceName: "baseline_favorite_black_18dp"), for: .normal)
            } else {
                cell.startButton.setImage(#imageLiteral(resourceName: "baseline_favorite_border_black_18dp"), for: .normal)
            }
            
            return cell
        }
        
        @objc func like(_ sender : UIButton){
            
            if(sender.currentImage == #imageLiteral(resourceName: "baseline_favorite_black_18dp")){
                sender.setImage(#imageLiteral(resourceName: "baseline_favorite_border_black_18dp"), for: .normal)
            } else {
                sender.setImage(#imageLiteral(resourceName: "baseline_favorite_black_18dp"), for: .normal)
            }
            
            Database.database().reference().child("users")
                .child(self.uidKey[sender.tag])
                .runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
                    if var post = currentData.value as? [String : AnyObject], let uid = Auth.auth().currentUser?.uid {
                        var stars: Dictionary<String, Bool>
                        stars = post["stars"] as? [String : Bool] ?? [:]
                        var starCount = post["starCount"] as? Int ?? 0
                        if let _ = stars[uid] {
                            // Unstar the post and remove self from stars
                            starCount -= 1
                            stars.removeValue(forKey: uid)
                        } else {
                            // Star the post and add self to stars
                            starCount += 1
                            stars[uid] = true
                        }
                        post["starCount"] = starCount as AnyObject?
                        post["stars"] = stars as AnyObject?
                        
                        // Set value and report transaction success
                        currentData.value = post
                        
                        return TransactionResult.success(withValue: currentData)
                    }
                    return TransactionResult.success(withValue: currentData)
                }) { (error, committed, snapshot) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
            }
      
        }
        
        
    }
    
    class CustomCell : UICollectionViewCell {
        
        @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var subject: UILabel!
        @IBOutlet weak var explanation: UILabel!
        @IBOutlet weak var startButton: UIButton!
        
    }

    cell.startButton.tag = indexPath.row
    cell.startButton.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)

⇒ addTarget → 보통 함수를 파라미터로 받아서 사용.

    //
    //  UserDTO.swift
    //  GoogleAuth
    //
    //  Created by shin seunghyun on 2020/02/29.
    //  Copyright © 2020 shin seunghyun. All rights reserved.
    //
    
    import UIKit
    
    class UserDTO: NSObject {
        
        var uid: String?
        var userId: String?
        var subject: String?
        var explanation: String?
        var imageUrl: String?
        var startCount: NSNumber?
        var stars: [String: Bool]?
        
    }

⇒ startCount, stars

🔵 Firebase Data Delete, Firebase Storage, Database

- Observer Pattern

⇒ 서버가 데이터를 바꿀 때마다 바로바로 바꿔줌

- firebase, storage, database 핸들링

    @objc func deletePost(_ sender: UIButton){
      
    	Storage.storage().reference().child("ios_images").child(self.array[sender.tag].imageName!).delete { (error) in
    	    if(error != nil){
    	        print("Error occured while deleting")
    	    } else {
    	        Database.database().reference().child("users").child(self.uidKey[sender.tag]).removeValue()
    	    }
    	}
    
    }

- image 서버에서 로딩할 때 비동기로 바꿔주기

    //Thread를 돌려서 loading 속도를 더 빠르게 한다.
    URLSession.shared.dataTask(with: URL(string: array[indexPath.row].imageUrl!)!) { (data, response, error) in
        if error != nil {
            return
        }
        DispatchQueue.main.async {
            cell.imageView.image = UIImage(data: data!)
        }
    }.resume()

🔵 Crash Report

[https://firebase.google.com/docs/crashlytics](https://firebase.google.com/docs/crashlytics)

1. Dependency 추가

    pod 'Crashlytics'
    pod 'Crashlytics', '~> 3.10.1'

 2.   App Setting에 Build Settings의 Debug Information Format을 `DWARF with dSYM File` 로 바꾼다. 

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/3c2e91bd-c6ce-4221-b455-ed3a0cc244ee/Screen_Shot_2020-02-29_at_23.14.58.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/3c2e91bd-c6ce-4221-b455-ed3a0cc244ee/Screen_Shot_2020-02-29_at_23.14.58.png)

 3.  App Setting에 Build Phases로 가서 script를 추가하고 아래 코드를 추가한다

    "${PODS_ROOT}/Fabric/run"

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/6475f9d6-0b3b-4a80-9174-b8cf1d1c53b3/Screen_Shot_2020-02-29_at_23.16.47.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/6475f9d6-0b3b-4a80-9174-b8cf1d1c53b3/Screen_Shot_2020-02-29_at_23.16.47.png)

❗️이것을 적용하면 코드가 자동으로 encrypt 된다.


2020.02.26

        //
        //  ViewController.swift
        //  HowlMapkit
        //
        //  Created by shin seunghyun on 2020/02/26.
        //  Copyright © 2020 shin seunghyun. All rights reserved.
        //

        import UIKit
        import MapKit

        class ViewController: UIViewController {

            
            @IBOutlet weak var mapKitView: MKMapView!
            //권한
            let locationManager = CLLocationManager()
            
            override func viewDidLoad() {
                super.viewDidLoad()
                // Do any additional setup after loading the view.
                
                //화면 찍을 위치
                let location = CLLocationCoordinate2D(latitude: 37.392448, longitude: 126.638831)
                
                //화면 찍는 부분과 description 추가
                let annotation = MKPointAnnotation()
                annotation.coordinate = location
                annotation.title = "Central Park"
                annotation.subtitle = "공원"
                
                //확대하는 부분 코드
                let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.1)
                //확대할 위치
                let region = MKCoordinateRegion(center: location, span: span)
                mapKitView.setRegion(region, animated: true)
                
                //실제로 mark를 찍어줌
                mapKitView.addAnnotation(annotation)
             
                //자기 위치 찍기
                //Info.plist에 Privacy - Location Always and When In Use Usage Description 를 줘야한다.
                locationManager.requestWhenInUseAuthorization()
                mapKitView.showsUserLocation = true
                
            }


        }


### 🔵 Notification (Without Server)

1. 권한 주기 - AppDelegate

        import UserNotifications

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                // Override point for customization after application launch.
                let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                    //Enable or disable features based on authorization
                }
                return true
        }

 2.  `UNUserNotificationCenterDelegate` 

    class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
        override func viewDidLoad() {
            super.viewDidLoad()
                     /* 아랫 부분 delegate */       
            UNUserNotificationCenter.current().delegate = self
            
        }
    }

 3.  Notification Logic

    @IBAction func notificationButton(_ sender: UIButton) {
            
            let content = UNMutableNotificationContent()
            content.title = NSString.localizedUserNotificationString(forKey: "Hello!", arguments: nil)
            content.body = NSString.localizedUserNotificationString(forKey: "Hello_message_body", arguments: nil)
            //Deliver the notification in five seconds
            content.sound = UNNotificationSound.default
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            //Schedule the notification
            let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request, withCompletionHandler: nil)
            
    }

 4.  delegate method, `userNotificationCenter` - `withCompletionHandler`

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.alert, .sound])
    }

 5.  전체 코드

    //
    //  ViewController.swift
    //  Notification
    //
    //  Created by shin seunghyun on 2020/02/25.
    //  Copyright © 2020 shin seunghyun. All rights reserved.
    //
    
    import UIKit
    import UserNotifications
    
    class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            UNUserNotificationCenter.current().delegate = self
            
        }
    
        @IBAction func notificationButton(_ sender: UIButton) {
            
            let content = UNMutableNotificationContent()
            content.title = NSString.localizedUserNotificationString(forKey: "Hello!", arguments: nil)
            content.body = NSString.localizedUserNotificationString(forKey: "Hello_message_body", arguments: nil)
            //Deliver the notification in five seconds
            content.sound = UNNotificationSound.default
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            //Schedule the notification
            let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request, withCompletionHandler: nil)
            
        }
        
        
        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.alert, .sound])
        }
        
        
        
    }

### 🔵 Button With Notification  (Without Server)

- survey

        //
        //  ViewController.swift
        //  Notification
        //
        //  Created by shin seunghyun on 2020/02/25.
        //  Copyright © 2020 shin seunghyun. All rights reserved.
        //
        
        import UIKit
        import UserNotifications
        
        class ViewController: UIViewController, UNUserNotificationCenterDelegate {
        
        @IBOutlet weak var label: UILabel!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let answer_1 = UNNotificationAction(identifier: "Good", title: "Lecture was great", options: [.foreground])
            let answer_2 = UNNotificationAction(identifier: "Not Good", title: "Lecture quality was poor", options: [.foreground])
            
            let category = UNNotificationCategory(identifier: "SelectBox", actions: [answer_1, answer_2], intentIdentifiers: [], options: [])
            UNUserNotificationCenter.current().setNotificationCategories([category])
            
            UNUserNotificationCenter.current().delegate = self
            
        }
    
        @IBAction func notificationButton(_ sender: UIButton) {
            
            let content = UNMutableNotificationContent()
            content.title = NSString.localizedUserNotificationString(forKey: "Hello!", arguments: nil)
            content.body = NSString.localizedUserNotificationString(forKey: "Hello_message_body", arguments: nil)
            content.categoryIdentifier = "SelectBox"
            //Deliver the notification in five seconds
            content.sound = UNNotificationSound.default
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            //Schedule the notification
            let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request, withCompletionHandler: nil)
            
        }
        
        
        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.alert, .sound])
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

---

### 🔵 Firebase Push Message

[https://firebase.google.com/docs/cloud-messaging/ios/client](https://firebase.google.com/docs/cloud-messaging/ios/client)

**i.** Team 등록, with paid account

**ii.** Apple에서 key를 발급받는다

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/47f115a9-c1be-45b7-b19d-12afe8d15af6/Screen_Shot_2020-02-26_at_21.31.08.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/47f115a9-c1be-45b7-b19d-12afe8d15af6/Screen_Shot_2020-02-26_at_21.31.08.png)

iii. Apple에서 발급 받은 file을 upload하고 Key id를 등록해준다 

- 기본적으로 apple account로 certificate를 등록해줘야 한다.

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/59e1e68c-82a8-4258-b9f8-3d98e4a5fcfa/Screen_Shot_2020-02-26_at_21.28.55.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/59e1e68c-82a8-4258-b9f8-3d98e4a5fcfa/Screen_Shot_2020-02-26_at_21.28.55.png)

⇒ Cloud Messaging Tab에서 apple APN key를 등록해준다.

IV. **background mode** & **remote notification 등록**

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/fa7dc506-0730-4daa-953d-9868dddea76e/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/fa7dc506-0730-4daa-953d-9868dddea76e/Untitled.png)

V. 코드삽입

- 아래 full code

        //
        //  AppDelegate.swift
        //  FirebasePushNotification
        //
        //  Created by shin seunghyun on 2020/02/26.
        //  Copyright © 2020 shin seunghyun. All rights reserved.
        //
        
        import UIKit
        import Firebase
        import UserNotifications
        
        @UIApplicationMain
        class AppDelegate: UIResponder, UIApplicationDelegate {
        
        let gcmMessageIDKey = "gcm.message.id"
    
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // Override point for customization after application launch.
            if #available(iOS 10.0, *) {
              // For iOS 10 display notification (sent via APNS)
              UNUserNotificationCenter.current().delegate = self
    
              let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
              UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            } else {
              let settings: UIUserNotificationSettings =
              UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
              application.registerUserNotificationSettings(settings)
            }
            Messaging.messaging().delegate = self
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
        
        
            
        @available(iOS 10, *)
        extension AppDelegate : UNUserNotificationCenterDelegate {
    
      // Receive displayed notifications for iOS 10 devices.
      func userNotificationCenter(_ center: UNUserNotificationCenter,
                                  willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
    
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
    
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
          print("Message ID: \(messageID)")
        }
    
        // Print full message.
        print(userInfo)
    
        // Change this to your preferred presentation option
        //핸드폰에 앱이 죽어있을 때는 push message가 잘가지만, app이 살아 있을 때는 push message가 잘 가지 않음. 그래서 completionHandler 아래에 app이 살아있을 때 어떻게 작동할지 코드를 넣어줌
        completionHandler([.alert])
      }
    
      func userNotificationCenter(_ center: UNUserNotificationCenter,
                                  didReceive response: UNNotificationResponse,
                                  withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
          print("Message ID: \(messageID)")
        }
    
        // Print full message.
        print(userInfo)
    
    
        completionHandler()
      }
    }
    
        
    
        
        extension AppDelegate: MessagingDelegate {
        
        //Token Refreshing
        func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
          print("Firebase registration token: \(fcmToken)")
    
          let dataDict:[String: String] = ["token": fcmToken]
          NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
          // TODO: If necessary send token to application server.
          // Note: This callback is fired at each app startup and whenever a new token is generated.
        }
        
        //메시지 받은 것.
        func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
            print("Message Data: \(remoteMessage.appData)")
        }
        
    


2020.02.25

### 🔵 Notification

1. 권한 주기 - AppDelegate

        import UserNotifications

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                // Override point for customization after application launch.
                let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                    //Enable or disable features based on authorization
                }
                return true
        }

 2.  `UNUserNotificationCenterDelegate` 

    class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
                `override func viewDidLoad() {
                    super.viewDidLoad()
                             /* 아랫 부분 delegate */       
                    `UNUserNotificationCenter.current().delegate = self
                    
                }`
            }`

 3.  Notification Logic

    @IBAction func notificationButton(_ sender: UIButton) {
            
            let content = UNMutableNotificationContent()
            content.title = NSString.localizedUserNotificationString(forKey: "Hello!", arguments: nil)
            content.body = NSString.localizedUserNotificationString(forKey: "Hello_message_body", arguments: nil)
            //Deliver the notification in five seconds
            content.sound = UNNotificationSound.default
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            //Schedule the notification
            let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request, withCompletionHandler: nil)
            
    }

 4.  delegate method, `userNotificationCenter` - `withCompletionHandler`

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.alert, .sound])
    }

 5.  전체 코드

    //
    //  ViewController.swift
    //  Notification
    //
    //  Created by shin seunghyun on 2020/02/25.
    //  Copyright © 2020 shin seunghyun. All rights reserved.
    //
    
    import UIKit
    import UserNotifications
    
    class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            UNUserNotificationCenter.current().delegate = self
            
        }
    
        @IBAction func notificationButton(_ sender: UIButton) {
            
            let content = UNMutableNotificationContent()
            content.title = NSString.localizedUserNotificationString(forKey: "Hello!", arguments: nil)
            content.body = NSString.localizedUserNotificationString(forKey: "Hello_message_body", arguments: nil)
            //Deliver the notification in five seconds
            content.sound = UNNotificationSound.default
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            //Schedule the notification
            let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request, withCompletionHandler: nil)
            
        }
        
        
        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.alert, .sound])
        }
        
        
        
 }


### 🔵 Privacy

- iOS에서 보안상의 이유로 만들어 놓은 것

1. 권한을 준다

info.plist 로 가서 값을 추가한다 

`Privacy - Camera Usage Description`  

⇒ 카메라

`Privacy - Photo Library Additions Usage Description`

⇒ 앨범

 2.  implements two essential Delegate

    UIImagePickerControllerDelegate, UINavigationControllerDelegate

 3.  코드

    import UIKit
    
    class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        }
    
        @IBAction func camera(_ sender: UIButton) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        @IBAction func album(_ sender: UIButton) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }

4. 권한 확인

- AVFoundation ⇒ 카메라
- Photos ⇒ 앨범

    //권한 받아오는 코드
            let camearaStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            
            if camearaStatus == .authorized {
                //승인
            } else if camearaStatus == .restricted {
                //일부 권한
            } else if camearaStatus == .notDetermined {
                //아직 물어보지 않음
            } else if camearaStatus == .denied {
                //거절 당함
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "권한", message: "카메라 권한을 받아오지 못했습니다.", preferredStyle: .alert)
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
                    let alert = UIAlertController(title: "권한", message: "사진 권한을 받아오지 못했습니다.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }

### 🔵 Camera - 사진 찍어서 저장

1. imagePickerController 함수를 가져온다
2. UIImageWriteToSavedPhotosAlbum(image, nil, nil ,nil)

    //사진을 찍으면 여기 함수가 작동된다. 사진 정보를 받아올 수 있다. => 이미지가 찍혔을 때 작동되는 코드
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imageView.contentMode = .scaleAspectFit
                imageView.image = pickedImage
            }
            
            dismiss(animated: true, completion: nil)
            
        }
        
        @IBAction func savePhoto(_ sender: UIButton) {
            
    //        let imageData = UIImage.jpegData(self.imageView.image!)
    //        let compressedImage = UIImage(data: imageData!)
            
            UIImageWriteToSavedPhotosAlbum(self.imageView.image!, nil, nil, nil)
            
        }

### 🔵 언어 추가

1. Scheme 변경

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/8278ac4d-3908-4c52-a54c-4e6046c8ce49/Screen_Shot_2020-02-25_at_22.41.01.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/8278ac4d-3908-4c52-a54c-4e6046c8ce49/Screen_Shot_2020-02-25_at_22.41.01.png)

⇒ 먼저 `Edit Scheme`을 클릭한 후에 언어를 바꿔준다.

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2c6b6460-55d4-4733-9553-fc3d756f6fbd/Screen_Shot_2020-02-25_at_22.41.51.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2c6b6460-55d4-4733-9553-fc3d756f6fbd/Screen_Shot_2020-02-25_at_22.41.51.png)

⇒ Run, Option 에 들어가서 언어를 바꿔준다.

 2.  앱 정보 화면에 가서 언어를 추가해준다.

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/6557e1a1-2752-4312-9cb9-e759895e561e/Screen_Shot_2020-02-25_at_22.43.02.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/6557e1a1-2752-4312-9cb9-e759895e561e/Screen_Shot_2020-02-25_at_22.43.02.png)

3. 자동으로 생성된 파일  `Main.strings` 파일에서 값 바꿔주기

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/8aedc534-463a-4416-8bbd-867c1be1a46b/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/8aedc534-463a-4416-8bbd-867c1be1a46b/Untitled.png)

    /* Class = "UIButton"; normalTitle = "Button"; ObjectID = "7rJ-nm-yEs"; */
    "7rJ-nm-yEs.normalTitle" = "버튼";

 4.  `Localizeable.strings` 파일 생성

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/24c0a981-1932-4063-9312-4ae258d98f82/Screen_Shot_2020-02-25_at_22.44.54.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/24c0a981-1932-4063-9312-4ae258d98f82/Screen_Shot_2020-02-25_at_22.44.54.png)

⇒ key 값을 기준으로 각각 번역해준다. 

    @IBAction func notificationButton(_ sender: UIButton) {
            
            let content = UNMutableNotificationContent()
            content.title = NSString.localizedUserNotificationString(forKey: "Hello!", arguments: nil)
            content.body = NSString.localizedUserNotificationString(forKey: "Hello_message_body", arguments: nil)
            //Deliver the notification in five seconds
            content.sound = UNNotificationSound.default
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            //Schedule the notification
            let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request, withCompletionHandler: nil)
            
    }

NSString.localizedUserNotificationString ⇒ 이 부분이 위 설정을 적용해서 자동으로 번역해주는 부분이다


2020.02.23

- layout practice
- tableView

        //
        //  ViewController.swift
        //  TableViewPractice
        //
        //  Created by shin seunghyun on 2020/02/23.
        //  Copyright © 2020 shin seunghyun. All rights reserved.
        //

        import UIKit

        class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
            
            @IBOutlet weak var tableView: UITableView!
            
            let images = ["image1.jpg", "image2.jpg", "image3.jpg"]
            
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return 3
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "RowCell", for: indexPath) as! rowDTO
                cell.rowLabel.text = "Test"
                cell.rowImage.image = UIImage(named: images[indexPath.row])
                return cell
            }

            override func viewDidLoad() {
                super.viewDidLoad()
                tableView.delegate = self
                tableView.dataSource = self
                tableView.rowHeight = UITableView.automaticDimension
                tableView.estimatedRowHeight = 10 //최소값
            }

        }

        /* TableViewCell에 아래 class를 binding 한다. */
        class rowDTO: UITableViewCell {
            
            @IBOutlet weak var rowImage: UIImageView!
            @IBOutlet weak var rowLabel: UILabel!
            
        }

- collectionView

        //
        //  ViewController.swift
        //  CollectionViewSimplifiedVersion
        //
        //  Created by shin seunghyun on 2020/02/23.
        //  Copyright © 2020 shin seunghyun. All rights reserved.
        //

        import UIKit

        class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

            let items = [ #imageLiteral(resourceName: "background") , #imageLiteral(resourceName: "image7") , #imageLiteral(resourceName: "background2") , #imageLiteral(resourceName: "13450078_290367081302103_5382854634955251492_n") , #imageLiteral(resourceName: "image1") ]
            
            override func viewDidLoad() {
                super.viewDidLoad()
                
                
                // Do any additional setup after loading the view.
            }

            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return items.count
            }
            
            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyCollectionCell
                cell.myImage.image = items[indexPath.row]
                return cell
            }
            
            func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                print(indexPath.item)
            }
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
                let width = collectionView.frame.width / 3
                
                return CGSize(width: width, height: width)
            }
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return 0
            }
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                //칼럼간의 간격
                return 0
            }

        }  

- 카카오톡 프로파일 메시지


        //
        //  ViewController.swift
        //  AdvancedTableView
        //
        //  Created by shin seunghyun on 2020/02/23.
        //  Copyright © 2020 shin seunghyun. All rights reserved.
        //

        import UIKit

        class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

            var Users = [UserDTO]();
            @IBOutlet weak var tableView: UITableView!
           
            
            override func viewDidLoad() {
                super.viewDidLoad()
                
                tableView.rowHeight = 80
            
                // Do any additional setup after loading the view.
                Users.append(UserDTO(imageString: "image1.jpg", name: "신승현", message: "성공하고 싶다"))
                Users.append(UserDTO(imageString: "image2.jpg", name: "김승현", message: "성공하고 싶다2"))
                Users.append(UserDTO(imageString: "image5.jpg", name: "이승현", message: "성공하고 싶다3"))
            }
            
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return 3
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "RowCell", for: indexPath) as! CustomCell
                
                //원그림 주기
                cell.profileImage.image = UIImage(named: Users[indexPath.row].imageString)
                cell.profileImage.layer.cornerRadius = (cell.profileImage.frame.width) / 2
                cell.profileImage.layer.masksToBounds = true
                
                cell.profileName.text = Users[indexPath.row].name
                cell.profileMessage.text = Users[indexPath.row].message
                
                //Bubble Speech => 늦게 만든 버블을 프로그래밍 적으로 위치를 지정함, bubbleSpeech를 profileMessage에 넣어준다. 상태메시지창.
                cell.bubbleSpeech.translatesAutoresizingMaskIntoConstraints = false
                cell.bubbleSpeech.leftAnchor.constraint(equalTo: cell.profileMessage.leftAnchor, constant: -10).isActive = true
                cell.bubbleSpeech.topAnchor.constraint(equalTo: cell.profileMessage.topAnchor, constant: -10).isActive = true
                cell.bubbleSpeech.rightAnchor.constraint(equalTo: cell.profileMessage.rightAnchor, constant: 10).isActive = true
                cell.bubbleSpeech.bottomAnchor.constraint(equalTo: cell.profileMessage.bottomAnchor, constant: 10).isActive = true
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


### 🔵 Subjects to be covered, Swift Advanced

- Swift Structures
- Structures vs Classes
- Internal/External Parameters
- Access Levels
- Tuples

        //
        //  ViewController.swift
        //  Calculator
        //
        //  Created by Angela Yu on 10/09/2019.
        //  Copyright © 2019 London App Brewery. All rights reserved.
        //

        import UIKit

        class ViewController: UIViewController {
            
            @IBOutlet weak var displayLabel: UILabel!
            
            var isFinishedTypingNumber: Bool = true
            
            @IBAction func calcButtonPressed(_ sender: UIButton) {
                
                //What should happen when a non-number button is pressed
                isFinishedTypingNumber = false
                
            }
            
            
            @IBAction func numButtonPressed(_ sender: UIButton) {
                
                //What should happen when a number is entered into the keypad
                if let numValue: String = sender.currentTitle {
                    
                    if isFinishedTypingNumber {
                        displayLabel.text = numValue
                        isFinishedTypingNumber = false
                    } else {
                        displayLabel.text = displayLabel.text! + numValue
                    }
                    
                }
                
            }
            
        }

### 🔵 Access Modifier

- `private`
- `fileprivate`
- `internal`  (default) ⇒ access all the file, all the other properties
- `public` ⇒ Access is granted for other modules
- `open`  ⇒ Everyone can access to it, Anybody can do anything they want.

    → ex) override

    → 보통 `blue` 의 색깔 파일.
- `private` ⇒ 같은 class 내에서만 사용이 가능하다
- `fileprivate` ⇒ 같은 file 내에서만 사용이 가능하다
- `internal` ⇒ project 내부에서 공유 가능


### 🔵 Advanced Swift Optionals

- guard ⇒ Instead of using `forced unwrapping` , use guard

    //Forcing unwrapping isn't always the best method
    guard let number = Double(displayLabel.text!) else {
        fatalError("Cannot convert display label text to a Double")
    }

**❗️Converting Value**

⇒ String to Double : it becomes `Optional Double`

⇒ Double to String : it becomes `Non-Optional String`

- Dealing with decimal

- `ceil()`

⇒ 소수점 아래의 숫자가 있으면 소수점 아래를 다 버리고 정수부에 1을 더해주는 함수입니다.

- `floor()` → Double

⇒ floor() 함수는 소수점 아래를 그냥 버린다

- `round()`

⇒ round() 반올림

### 🔵 Struct vs Class

- Struct (Value Type)
- Class (Reference Type)

❗️Use struct as much as possible 

❗️Struct is more predictable  

- 모두 똑같은 object를 reference 하고 있는 것에 대한 예

        //
        //  main.swift
        //  Struct vs Class
        //
        //  Created by shin seunghyun on 2020/02/23.
        //  Copyright © 2020 shin seunghyun. All rights reserved.
        //
        
        import Foundation
        
        var hero: ClassHero = ClassHero(name: "Iron Man", universe: "Marvel")
        
        var anotherMarvelHero = hero
        anotherMarvelHero.name = "The Hulk"
        
        var avengers = [hero, anotherMarvelHero]
        
        avengers[0].name = "Thor"
        
        print("Hero name = \(hero.name)")
        print("anotherMarvelHero name = \(anotherMarvelHero.name)")
        print("first avenger name = \(avengers[0].name)")

- struct에서 `init()` 대신 `let` 을 사용하여 constructor를 만들었다면 값을 변환할 수 없다.

        var hero: StructHero = StructHero(name: "Iron Man", universe: "Marvel")
        
        hero.name = "Hulk" //Throwing Error

- Whenever you want to change the property, you need to put the keyword `mutating`

        import Foundation
        
        struct StructHero {
            
            let name: String
            let universe: String
            
            
            mutating func reverseName() -> String {
                return String(self.name.reversed())
            }
            
        }


2020.02.19 - Realm 공부 완료

        ### 🔵 Realm Installation

- podFile

        # Uncomment the next line to define a global platform for your project
        platform :ios, '9.0'
        
        target 'Todoey' do
          # Comment the next line if you don't want to use dynamic frameworks
          use_frameworks!
        
          # Pods for Todoey
          pod 'RealmSwift'
        
        end

- AppDelegate

        //
        //  AppDelegate.swift
        //  Todoey
        //
        //  Created by Angela Yu on 16/11/2017.
        //  Copyright © 2017 Angela Yu. All rights reserved.
        //
        
        import UIKit
        import CoreData
        import RealmSwift
        
        @UIApplicationMain
        class AppDelegate: UIResponder, UIApplicationDelegate {
            
            var window: UIWindow?
            
            
            func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
                do {
                    let realm = try Realm()
                } catch {
                    print("Error initialising new realm, \(error)")
                }
                return true
            }
            
        
        }

- `dynamic` keyword

⇒ Dynamic is what's called as `declaration modifier`.

⇒ It happens while compiling, which allows the data to be changed dynamically on Runtime Environment

⇒ It came from Objective-C

- Realm Root Check

⇒ `Realm.Configuration.defaultConfiguration.fileURL`

- 곧바로 file URL로 가는 방법

⇒ MAC OS 기준, finder에서   `command` + `shift` + `g`

### 🔵Swift Error Handling

- Swift `try` is the most basic way of dealing with functions that can throw errors
- `try?` is used to handle errors by converting the error into an optional value. **This way if an error occurs, the function would return a nil** and we know Optionals can be nil in Swift. Hence for `try?` you can get rid of `do-catch` block
- `**try!` is used to assert that the error won't occur.** Should be only used when you're absolutely sure that the function won't throw an error. Like `try?` , `try!` works without a do-catch block.

### 🔵 Define DataModel and Relationship

- Realm Model, Parent - Category

        //
        //  Category.swift
        //  Todoey
        //
        //  Created by shin seunghyun on 2020/02/18.
        //  Copyright © 2020 Angela Yu. All rights reserved.
        //
        
        import Foundation
        import RealmSwift
        
        class Category: Object {
            @objc dynamic var name: String = ""
            
            //Relationship - Inside of the each Category, it contains items, `One to Many` => Forward Relationship
            let items: List<Item> = List<Item>()
        }

⇒ One to Many `let items: List<Item> = List<Item>()`

    - Realm Model, Children - Item

        //
        //  Item.swift
        //  Todoey
        //
        //  Created by shin seunghyun on 2020/02/18.
        //  Copyright © 2020 Angela Yu. All rights reserved.
        //
        
        import Foundation
        import RealmSwift
        
        class Item: Object {
            @objc dynamic var title: String = ""
            @objc dynamic var done: Bool = false
                @objc dynamic var dateCreated: Date?
            
            //Relationship - Inverse Relationship of Items, one to one => Inverse Relationship
            var parentCategory: LinkingObjects = LinkingObjects(fromType: Category.self, property: "items")
            
        }

⇒ one to one `var parentCategory: LinkingObjects = LinkingObjects(fromType: Category.self, property: "Items")`

### 🔵 Initialize Realm

    let realm = try! Realm()

### 🔵 Create (Write)

    do {
        try realm.write {
            realm.add(data)
        } catch {
            print("Error saving category \(error)")
        } 
    }

### 🔵 Read

- Data to be loaded ⇒ Define it with `Results<?>` which is provided by Realm. It's basically an array

    var categories: Results<Category>?

⇒ Results<Category> 값이 없을 수도 있기 때문에  optional `?` 을 넣어준다.

⇒ 참고로 `Results<?>` 로 값을 지정해주면 `array.append()` 를 호출하지 않아도 된다. 데이터를 write 하면 자동으로 ui에 표시된다.

- get data

        categories = realm.objects(Category.self)

- get data with query

        todoItemArray = 
        selectedTodoParent?
        .items
        .sorted(byKeyPath: "title", ascending: true)

        LinkingObjects(fromType: ?, property: "?")
        .items

        .sorted(byKeyPath: "?", ascending: true )

❗️Realm을 사용하면 굳이 ui에 logic을 작성하지 않아도 데이터가 바뀐대로 ui에 적용된다.

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
            if let todoItem = todoItemArray?[indexPath.row] {
                cell.textLabel?.text = todoItem.title
                cell.accessoryType = todoItem.done ? .checkmark : .none
            } 
            return cell
        }

### 🔵 Update - `realm.write { }`

    do {
        try realm.write {
            todoItem.done = !todoItem.done
        } 
    } catch {
        print("Error saving done status, \(error)")
    }

### 🔵 Delete = `realm.write { realm.delete(data) }`

### 🔵 NSPredicate Examples

    NSCompoundPredicate(
        type: .and,
        subpredicates: [
            NSPredicate(format: "age > 25"),
            NSPredicate(format: "firstName = %@", "Quentin")
        ]   
    )
    
    NSPredicate(format: "(age > 25) AND (firstName = %@)", "Quentin")

### 🔵 Querying Data Using Realm

    //NSPredicate
    todoItemArray =
        todoItemArray?
            .filter("title CONTAINS[cd] %@", searchBar.text)
            .sorted(byKeyPath: "dateCreated", ascending: true)
    
    tableView.reloadData()

### 🔵 Error Handling

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/69ab0326-bea4-4233-b15f-fe75c51cfc6f/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/69ab0326-bea4-4233-b15f-fe75c51cfc6f/Untitled.png)

⇒ 이전에 데이터들을 업데이트하거나 다 지워준다. 

---

### 🔵 Making Our Cells Swipable

- frontend part

### 🔵 Get the library

- cocoaPod

            # Uncomment the next line to define a global platform for your project
            platform :ios, '9.0'
            
            target 'Todoey' do
              # Comment the next line if you don't want to use dynamic frameworks
              use_frameworks!
            
              # Pods for Todoey
              `pod 'RealmSwift'`
              `pod 'SwipeCellKit'`    
            
            end

- import

        import SwipeCellKit

- cast cell as `SwipeCellKit`

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
            cell.textLabel?.text = todoParents?[indexPath.row].name ?? "No Categories added"
            cell.delegate = self
            return cell
        }

- implement `protocol` and related `methods`

        //Mark: - Swipe Cell Delegate Methods
        
        extension CategoryViewController: SwipeTableViewCellDelegate {
            
            func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
                
                guard orientation == .right else { return nil}
                
                let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (SwipeAction, IndexPath) in
                    // Handle action by updating model with deletion
                    print("Item deleted")
                }
                
                // customize the action appearance
                deleteAction.image = UIImage(named: "delete-icon")
                
                return [deleteAction]
            }
            
        }

- Connect `tableCell` to `SwipeTableCell` as well as with modules

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/6b8fa87a-d7ad-431e-a92c-08276216e9b7/Screen_Shot_2020-02-19_at_14.52.04.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/6b8fa87a-d7ad-431e-a92c-08276216e9b7/Screen_Shot_2020-02-19_at_14.52.04.png)

### 🔵 Deletion Handling

    let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (swipeAction, indexPath) in
                // Handle action by updating model with deletion
                
                if let categoryForDeletion = self.todoParents?[indexPath.row]{
                    do {
                        try self.realm.write {
                            self.realm.delete(categoryForDeletion)
                        }
                    } catch {
                        print("Error deleting Item: \(error)")
                    }
                    tableView.reloadData()
                }
            }

### 🔵 Expansion

    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
            var options = SwipeOptions()
            options.expansionStyle = .destructive //remove
            return options
    }

⇒ Expansion Animation 추가

### 🔵 Inheritance

- TableView Datasource Methods, SwipeTableViewController

        //TableView Datasource Methods
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
            cell.delegate = self
            return cell
        }

- Method which returns Cell, CategoryTableViewController

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = super.tableView(tableView, cellForRowAt: indexPath) //SwipeTableViewController에서 알아서 SwipeTableViewCell로 각각의 cell들을 casting 해준다.
            cell.textLabel?.text = todoParents?[indexPath.row].name ?? "No Categories Added Yet"
            return cell
        }

### 🔵 Cameleon Color Framework ⇒ Color Library

    cell.backgroundColor = UIColor.randomFlat()
    

### ❗️ DB 에 내용 추가해서 에러날 때,

- 앱을 삭제하고 재설치한다.

### 🔵 Gradient Effect

- What we want : Progressively darker and darker

        if let color = FlatSkyBlue().darken(byPercentage: CGFloat(indexPath.row) / CGFloat(todoItemArray!.count)) {
              cell.backgroundColor = color
              cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
        }

⇒ in `tableView()` 

- FlatSkyBlue() , darken() 등, ChameleonFramework 에서 기본적으로 제공하는 함수
- `ContrastColorOf` 를 사용하면 자동으로 contrast를 고려하여 색이 바뀜

        if let color = UIColor(hexString: self.selectedColor!)!.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(todoItemArray!.count)) {
              cell.backgroundColor = color
              cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
        }

⇒ 기본적인 `UIColor` 에서 사용 가능

### 🔵 Large Text Navigation Bar

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/341eb82b-27c8-4e6f-956d-a4da8d725533/Screen_Shot_2020-02-19_at_18.04.54.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/341eb82b-27c8-4e6f-956d-a4da8d725533/Screen_Shot_2020-02-19_at_18.04.54.png)

### 🔵 Control `NavigationController` programatically

    override func viewWillAppear(_ animated: Bool) {
            if let colorHex = selectedColor {
                title = selecetedTodoParent!.name
                guard let navBar = navigationController?.navigationBar else { fatalError("Navigation Controller does not exist.") }
                if let navBarColor = UIColor(hexString: colorHex){
                    navBar.backgroundColor = navBarColor
                    navBar.barTintColor = navBarColor
                    navBar.tintColor = ContrastColorOf(navBarColor, returnFlat: true)
                    navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ContrastColorOf(navBarColor, returnFlat: true)]
                }
            }
        }

        

2020.02.16

20.02.16 - Swift Data Persistence - todolist app

- Basic Setting

        import UIKit

        class ViewController: UITableViewController {
            
            //Hard Coded items
            let itemArray: [String] = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
            
            override func viewDidLoad() {
                super.viewDidLoad()
                
                
            }
            
            //MARK - tableview datasource methods
            override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return itemArray.count
            }
            
            override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
                cell.textLabel?.text = itemArray[indexPath.row] //굳이 custom itemCell을 만들지 않아도 기본적으로 테스트 하느 정도는 이렇게 넣을 수 있다.
                return cell
            }
            
        }

- TableView Delegate Method added

        //
        //  ViewController.swift
        //  Todoey
        //
        //  Created by Philipp Muellauer on 02/12/2019.
        //  Copyright © 2019 App Brewery. All rights reserved.
        //

        import UIKit

        class ViewController: UITableViewController {
            
            //Hard Coded items
            let itemArray: [String] = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
            
            override func viewDidLoad() {
                super.viewDidLoad()
                
                
            }
            
            //MARK - tableview datasource methods
            override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return itemArray.count
            }
            
            override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
                cell.textLabel?.text = itemArray[indexPath.row]
                return cell
            }

            //유저가 선택할 때마다 특정 로직을 넣을 수 있음
            override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                print(itemArray[indexPath.row])
                tableView.deselectRow(at: indexPath, animated: true)
                
            }
            
            
        }

- TableCell Accessory Control

        //유저가 선택할 때마다 특정 로직을 넣을 수 있음
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
            } else {
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }
            
            tableView.deselectRow(at: indexPath, animated: true)
        }

- Alert Dialog

        @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
            
            var textField: UITextField = UITextField()
            
            let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
                //What will happen once the user clicks the Add Item button on our UIAlert
                if let newItem: String = textField.text {
                    self.itemArray.append(newItem)
                    self.tableView.reloadData()
                }
            }
            //dialog에 textfield 추가
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create new item"
                textField = alertTextField
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        }

- Check if data is stored (using NSencoding)

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                // Override point for customization after application launch.
                
                print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
                
                return true
        }
        
- store and load date using `UserDefaults`

        //Field
        let defaults: UserDefaults = UserDefaults.standard

        //Save the data
        defaults.set(dataYouWantToStore, forKey: "TodoListArray")

        //Load the data
        if let items = defaults.array(forKey: "TodoListArray") as? [String]{
               itemArray = items
        }

- UserDefaults Explaiend
    - It can use only for `standard` datatype
    - `userDefaults` are not that efficient
    - Use `userDefaults` for a small trick like audio `volume up` or `volum down`
    - 굳이 덧붙이자면 sharedpreferences와 비슷
    
            import UIKit

            let defaults = UserDefaults.standard

            defaults.set(0.24, forKey: "Volume")
            defaults.set(true, forKey: "MusicOn")
            defaults.set("Angela", forKey: "PlayerName")
            defaults.set(Date(), forKey: "AppLastOpenedByUser")

            let array = [1, 2, 3]
            defaults.set(array, forKey: "myArray")
            let dictionary = ["name": "Angela"]
            defauls.set(dictionary, forKey: "myDictionary")


            let volume = defaults.float(forKey: "Volume")
            let appLastOpen = defaults.object(forKey: "AppLastOpenedByUser")
            let myArray = defaults.array(forKey: "myArray")
            let myDictionary = defaults.dictionary(forKey: "myDictionary")

- Swift Singleton
    - 보통 built-in object 중 `defaults`라는 키워드를 달고 있으면 singleton임
    
            class Car {
                var color = "Red"
                
                static let singletonCar = Car()
            }

            class A {
                init(){
                    Car.singletonCar.color = "Brown"
                }
            }

            class B {
                init(){
                    print(Car.singletonCar.color)
                }
            }

- Encoding data with NSCoder (for only single table)
    - path 설정 및 initialization. -> 어디다 저장할지 정하는 것

            
            let dataFilePath = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask).first?.appendingPathComponent("Items.plist")


    - 데이터 저장


            func saveItems(){
                let encoder = PropertyListEncoder()
                do {
                    let data = try encoder.encode(self.itemArray)
                    try data.write(to: self.dataFilePath!)
                } catch {
                    print("Error encoding item array, \(error)")
                }
                
                self.tableView.reloadData()
            }

    - 데이터 불러오기

            func loadItems() {
                if let data = try? Data(contentsOf: dataFilePath!){
                    do {
                        let decoder = PropertyListDecoder()
                        itemArray = try decoder.decode([Item].self, from: data)
                    } catch {
                        print("Error decoding item array")
                    }
                }
            }


    - model에 반드시 codable 또는 encodable, decodable protocol 적용

            import Foundation

            struct Item: Codable {
                var title: String = ""
                var done: Bool = false
            }

- iOS daabase
    - UserDefaults: Quickly persist small bits of data : top score, player nickname, music on/off
    - Codable: Flash freeze custom objects
    - KeyChain: Save small bits of data securely
    - SQLite: Persist large amounts of data and query it
    - Core Data: Object-oriented databse
    - Realm: A faster and easier databse solution


- Core data
    - 처음에 app을 만들 때 coredata를 설정해서 프로젝트를 시작

                //
            //  AppDelegate.swift
            //  CoreDataTest
            //
            //  Created by shin seunghyun on 2020/02/16.
            //  Copyright © 2020 shin seunghyun. All rights reserved.
            //

            import UIKit
            import CoreData

            @UIApplicationMain
            class AppDelegate: UIResponder, UIApplicationDelegate {



                func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                    // Override point for customization after application launch.
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

                // MARK: - Core Data stack

                lazy var persistentContainer: NSPersistentContainer = {
                    /*
                     The persistent container for the application. This implementation
                     creates and returns a container, having loaded the store for the
                     application to it. This property is optional since there are legitimate
                     error conditions that could cause the creation of the store to fail.
                    */
                    let container = NSPersistentContainer(name: "CoreDataTest")
                    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                        if let error = error as NSError? {
                            // Replace this implementation with code to handle the error appropriately.
                            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                             
                            /*
                             Typical reasons for an error here include:
                             * The parent directory does not exist, cannot be created, or disallows writing.
                             * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                             * The device is out of space.
                             * The store could not be migrated to the current model version.
                             Check the error message to determine what the actual problem was.
                             */
                            fatalError("Unresolved error \(error), \(error.userInfo)")
                        }
                    })
                    return container
                }()

                // MARK: - Core Data Saving support

                func saveContext () {
                    let context = persistentContainer.viewContext
                    if context.hasChanges {
                        do {
                            try context.save()
                        } catch {
                            // Replace this implementation with code to handle the error appropriately.
                            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                            let nserror = error as NSError
                            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                        }
                    }
                }

            }


- Name Matching with CoreData File Name

                lazy var persistentContainer: NSPersistentContainer = {
                /*
                 The persistent container for the application. This implementation
                 creates and returns a container, having loaded the store for the
                 application to it. This property is optional since there are legitimate
                 error conditions that could cause the creation of the store to fail.
                */
                let container = NSPersistentContainer(name: "DataModel") //`****이부분 반드시 core data file name과 같아야 한다`
                container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                    if let error = error as NSError? {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                         
                        /*
                         Typical reasons for an error here include:
                         * The parent directory does not exist, cannot be created, or disallows writing.
                         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                         * The device is out of space.
                         * The store could not be migrated to the current model version.
                         Check the error message to determine what the actual problem was.
                         */
                        fatalError("Unresolved error \(error), \(error.userInfo)")
                    }
                })
                return container
            }()


- Core data 기본 설정
    - code gen : Class Definition
    - 보통 개발자들이 추가적인 코드를 작성하고 싶을 때, category/extension으로 설정해두기도 한다

    - AppDelegate file에 반드시 이 코드를 추가해주어야함.

        func applicationWillTerminate(_ application: UIApplication) {
            self.saveContext()
        }


- Lazy Keyword
    - lazy keyword를 달면, 해당 로직을 사용할 때만 메모리를 차지하게 한다.

            lazy var persistentContainer: NSPersistentContainer = {
                let container = NSPersistentContainer(name: "DataModel")
                container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                    if let error = error as NSError? {
                        fatalError("Unresolved error \(error), \(error.userInfo)")
                    }
                })
                return container
            }()

- initialize

        let context = 
        (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer
        .viewContext

- write & update

        func saveItems(){
        
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                
            }
            
            self.tableView.reloadData()
        }

- read


             func loadItems() {
                    let request: NSFetchRequest<Item> = Item.fetchRequest()
                    do {
                        itemArray = try context.fetch(request)
                    } catch {
                        print("Error fetching data from context \(error)")
                    }
                }

- delete
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            context.delete(itemArray[indexPath.row])
            itemArray.remove(at: indexPath.row)

            saveItems()
            tableView.deselectRow(at: indexPath, animated: true)
        }


- searchbar handling

                //MARK: - Search bar Methods
        extension ViewController: UISearchBarDelegate{
            
            func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
                //Set up the query
                let request : NSFetchRequest<Item> = Item.fetchRequest()
                let predicate = NSPredicate(format: "title CONTAINS %@", searchBar.text!)
                request.predicate = predicate
                
                //Sort Data
                let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
                request.sortDescriptors = [sortDescriptor]
                
                //Set the item
                do {
                    itemArray = try context.fetch(request)
                } catch {
                    print("Error fetching data from context \(error)")
                }
                
                tableView.reloadData()
            }
            
        }

- parameter에 값이 없을 때 default value 넣는 방법

        func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
        }

- go back to original state (when using searchbar)


        //MARK: - Search bar Methods
        extension ViewController: UISearchBarDelegate{
            
            func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
                //Set up the query
                let request : NSFetchRequest<Item> = Item.fetchRequest()
                request.predicate = NSPredicate(format: "title CONTAINS %@", searchBar.text!)
                
                //Sort Data
                request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
                
                //Set the item
                loadItems(with: request)
                
            }
            
            func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                if searchBar.text?.count == 0 {
                    loadItems()
                    
                    DispatchQueue.main.async {
                        searchBar.resignFirstResponder() //다시 처음 상태로 돌아감
                    }
                    
                }
            }
            
        }


20.02.14

- Swift UI
    - Easy Layouts `VHZ Stack` (Vertical, Horizontal, Z-index)
    - Inspiration came from `WebFramework`
    - Highly Reusable UI
    - **Cross Platform User interface (Across iOS cross platform)**
    - Environment: MacOS Catalina
    - Only iOS3
    - **iPhone 6S or later**
    - **iPad AIR 2 or later**
    
    - Objective
        1. How to start your first SwiftUI Project
        2. Work with Xcode preview and the object library to generate SwiftUI code
        3. Learn to use SwiftUI modifies to set properties for components
        4. Learn how to arrange elements using SwiftUI Stacks
        5. Learn how to add and size Image components

- I am Rich App

        //
        //  ContentView.swift
        //  myApp
        //
        //  Created by shin seunghyun on 2020/02/13.
        //  Copyright © 2020 shin seunghyun. All rights reserved.
        //

        import SwiftUI

        struct ContentView: View {
            
            var body: some View {
                ZStack {
                    Color(.systemTeal)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Text("I Am Rich")
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        Image("diamond")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:200, height: 200, alignment: .center)
                    }
                    
                }
            }
        }

        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                ContentView()
            }
        }
        
- Business Card App
    - font file을 넣을 때 permission을 준다.
    - `Create folder references` 로 폴더를 연결해줘야 한다.
    - Custom Font, Search for `Fonts provided by application`
    
            //
            //  ContentView.swift
            //  BusinessCardApp
            //
            //  Created by shin seunghyun on 2020/02/13.
            //  Copyright © 2020 shin seunghyun. All rights reserved.
            //

            import SwiftUI



            struct ContentView: View {
                

                
                var body: some View {
                    ZStack {
                        Color(red: 0.10, green: 0.74, blue: 0.52)
                            .edgesIgnoringSafeArea(.all)
                        VStack {
                            
                            Image("ideal")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150.0, height: 150.0)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color.white, lineWidth: 5)
                                )
                            Text("Shin SeungHyun")
                                .font(Font.custom("Pacifico-Regular", size: 40))
                                .bold()
                                .foregroundColor(.white)
                            Text("iOS Developer")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                            Divider()
                            
                            //My answer
            //                Text("+44 123 456 789")
            //                    .foregroundColor(.black)
            //                    .font(.largeTitle).bold()
            //                    .padding(15)
            //                .background(
            //                    RoundedRectangle(cornerRadius: 50).foregroundColor(.white)
            //                )
                            
                             
                            //Instructors Example
                            
                            InfoView(text: "+44 123 456 789", imageName: "phone.fill")
                            InfoView(text: "paige@gmail.com", imageName: "envelope.fill")
                        
                        }
                    }
                }
            }

            struct ContentView_Previews: PreviewProvider {
                static var previews: some View {
                    ContentView()
                }
            }
            
- Business Name Card App, Component

        //
        //  InfoView.swift
        //  BusinessCardApp
        //
        //  Created by shin seunghyun on 2020/02/13.
        //  Copyright © 2020 shin seunghyun. All rights reserved.
        //

        import SwiftUI

        struct InfoView: View {
            
            let text: String
            let imageName: String
            
            var body: some View {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.white)
                    .frame(height: 50)
                    .overlay(HStack {
                        Image(systemName: imageName)
                            .foregroundColor(.green)
                        Text(text).foregroundColor(.black)
                    })
                    .padding(.all)
            }
        }


        struct InfoView_Previews: PreviewProvider {
            static var previews: some View {
                InfoView(text: "+44 123 456 789", imageName: "phone.fill")
                    .previewLayout(.sizeThatFits)
            }
        }
    
- Dicee App
    - State
    
            import SwiftUI

            struct ContentView: View {
                
                @State var leftDiceNumber: Int = 1
                @State var rightDiceNumber: Int = 2
                
                var body: some View {
                    ZStack {
                        Image("background")
                            .resizable()
                            .edgesIgnoringSafeArea(.all)
                        VStack {
                            Image("diceeLogo")
                            
                            Spacer()
                            
                            HStack {
                                DiceView(n: leftDiceNumber)
                                DiceView(n: rightDiceNumber)
                            }
                            .padding(.horizontal)
                            
                            Spacer()
                            
                            Button(action: {
                                
                                self.leftDiceNumber = Int.random(in: 1...6)
                                self.rightDiceNumber = Int.random(in: 1...6)
                                
                            }){
                                Text("Roll")
                                    .font(.system(size: 50))
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                            }
                            .background(Color.red)
                            
                        }
                        
                    }
                }
            }

            struct DiceView: View {
                let n: Int
                var body: some View {
                    Image("dice\(n)")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .padding()
                }
            }


            struct ContentView_Previews: PreviewProvider {
                static var previews: some View {
                    ContentView()
                }
            }

- Hacker News
    - Identifiable
    - PostData, ( Data Model )
    - `@Published`
    - `@ObservableObject`
    
    - Model
    
            import Foundation

            struct Results: Decodable {
                
                let hits: [Post]
                
                
            }

            struct Post: Decodable, Identifiable {
                
                var id: String {
                    return objectID
                }
                let objectID: String
                let points: Int
                let title: String
                let url: String
                
            }
    
    -> When you use `Identifiable` protocol, you should implement `id`
    
    
    - Observable Pattern
    
            import Foundation
            
            class NetworkManager: ObservableObject {
                
                @Published var posts = [Post]() //PostObject, 생성자.    -   @Published 를 사용하면, 데이터가 바뀔 때마다 detection이 된다.
                
                func fetchData(){
                    if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") {
                        
                        let session:URLSession = URLSession(configuration: .default)
                        let task = session.dataTask(with: url) { (data, response, error) in
                            
                            if error == nil {
                                let decoder = JSONDecoder()
                                if let safeData = data {
                                    do {
                                        let results = try decoder.decode(Results.self, from: safeData)
                                        DispatchQueue.main.async {
                                            self.posts = results.hits
                                        }
                                    } catch {
                                        print(error)
                                    }
                                }
                            }
                        }
                        task.resume()
                    }
                }
            }
    -> implement Protocol `Observable Object`
    -> Note that we added `@Published`
    
    - Use the data
    
            import SwiftUI

            struct ContentView: View {
                
                @ObservedObject var networkManager = NetworkManager()
                
                var body: some View {
                    NavigationView {
                        //List Loop
                        List(networkManager.posts){ post in
                            HStack {
                                Text(String(post.points))
                                Text(post.title)
                            }
                        }
                        .navigationBarTitle("H4X0R NEWS")
                    }
                    .onAppear { // viewDidLoad(), Async
                        self.networkManager.fetchData()
                    }
                }
            }

            struct ContentView_Previews: PreviewProvider {
                static var previews: some View {
                    ContentView()
                }
            }
    
    -> Here we added `ObservedObjet`
    
    - NavigationLink, SwiftUI의 hyperlink 같은 개념이다.
    
            import SwiftUI
            
            struct ContentView: View {
                
                @ObservedObject var networkManager = NetworkManager()
                
                var body: some View {
                    NavigationView {
                        //List Loop
                        List(networkManager.posts){ post in
                            //a tag로 감싸주는 느낌
                            NavigationLink(destination: DetailView(url: post.url)){
                                HStack {
                                    Text(String(post.points))
                                    Text(post.title)
                                }
                            }
                            
                        }
                        .navigationBarTitle("H4X0R NEWS")
                    }
                        .onAppear { // viewDidLoad(), Async
                            self.networkManager.fetchData()
                    }
                }
            }
            
            struct ContentView_Previews: PreviewProvider {
                static var previews: some View {
                    ContentView()
                }
            }
    
    - WebView -> SwiftUI에서 Webview를 지원하지 않기때문에 webview를 직접 만들어 줘야한다.
    
            //WebView
            struct WebView : UIViewRepresentable {
                
                let urlString: String?
                
                func makeUIView(context: Context) -> WebView.UIViewType {
                    return WKWebView()
                }
                func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
                    if let safeString = urlString {
                        if let url = URL(string: safeString) {
                            let request = URLRequest(url: url)
                            uiView.load(request)
                        }
                        
                    }
                }
            }
            
    - DetailView
    
            import SwiftUI
            import WebKit

            struct DetailView: View {
                
                let url: String?
                
                var body: some View {
                    Text("Hello, World!")
                }
            }

            struct DetailView_Previews: PreviewProvider {
                static var previews: some View {
                    DetailView(url: "https://www.google.com")
                }
            }

            //WebView
            struct WebView : UIViewRepresentable {
                
                let urlString: String?
                
                func makeUIView(context: Context) -> WebView.UIViewType {
                    return WKWebView()
                }
                func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
                    if let safeString = urlString {
                        if let url = URL(string: safeString) {
                            let request = URLRequest(url: url)
                            uiView.load(request)
                        }
                        
                    }
                }
            }
            
    - WebView Component 화
    
            //
            //  WebView.swift
            //  H4XDR news
            //
            //  Created by shin seunghyun on 2020/02/14.
            //  Copyright © 2020 shin seunghyun. All rights reserved.
            //

            import Foundation
            import WebKit
            import SwiftUI

            //WebView
            struct WebView : UIViewRepresentable {
                
                let urlString: String?
                
                func makeUIView(context: Context) -> WKWebView {
                    return WKWebView()
                }
                func updateUIView(_ uiView: WKWebView, context: Context) {
                    if let safeString = urlString {
                        if let url = URL(string: safeString) {
                            let request = URLRequest(url: url)
                            uiView.load(request)
                        }
                        
                    }
                }
            }

20.02.13

- Custoizing Cells in TableView using a .xib File (Android itemview)
    - Cocoa file, MessageCell.xib 로 만들기
    - Create a new `UITableViewCell` with `XIB` file
    - MessageCell
        - UIView
        - Label
        - ImageView
    - Constraint
        - ImageView width & height, 40 & 40
        - StackView 10, 10, 10, 10
        - label 10, 10, 10, 10
    - StackView, spacing 20 (padding 또는 margin)
    
- Register the TableCell into the TableView
    - Register Customized ItemView
    
    - viewDidLoad
    
            tableView.register(UINib(nibName: K.cellNibName, bundle: nil),forCellReuseIdentifier: K.cellIdentifier)
    
    - data binding where tableview is declared as `outlet`
    
            extension ChatViewController: UITableViewDataSource {
                
                func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                    return messages.count
                }
                
                func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                    //Data Binding
                    let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
            //        cell.textLabel?.text = messages[indexPath.row].body
                    return cell
                }
                
            }
    
- Control thew view (Table Cell)

        import UIKit

        class MessageCell: UITableViewCell {

            @IBOutlet weak var messageBubble: UIView!
            @IBOutlet weak var label: UILabel!
            @IBOutlet weak var rightImageView: UIImageView!
            
            override func awakeFromNib() {
                super.awakeFromNib()
                
                        //Message View의 모서리 부분을 둥글게 만들기
                messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
            }

            override func setSelected(_ selected: Bool, animated: Bool) {
                super.setSelected(selected, animated: animated)

                // Configure the view for the selected state
            }
            
        }
        
- Chat Applicatoin Necessary Property
    - 각 셀마다 interaction은 disable 한다
    - Label => lines: 0, 이렇게 해야 label 크기에 따라 텍스트가 짤리는 경우가 없어짐
    
-  EventHandler  
    - 원래는 TableView를 사용할 때, UITableViewDataSource로 로직처리가 가능.
    - UITableViewDelegate도 존재
    
            override func viewDidLoad() {
                    super.viewDidLoad()
                    tableView.delegate = self
                    title = K.appName
                    navigationItem.hidesBackButton = true
                    
                    //Register ItemView
                    tableView.register(UINib(nibName: K.cellNibName, bundle: nil),
                    forCellReuseIdentifier: K.cellIdentifier)
                    
                }

            //Click Event Handler
            extension ChatViewController: UITableViewDelegate {
                func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                    print(indexPath.row)
                }
            }
 
 - Type Casting
 `as` , `as?` , `as!` , `is`
 
    -`is` => Type Checking
    
        import Foundation

        class Animal {
            var name: String
            
            init(n: String){
                name = n
            }
        }

        class Human: Animal {
            func code(){
                print("Typing away...")
            }
        }

        class Fish: Animal{
            func breathUnderWater(){
                print("Breathing under water.")
            }
        }

        let angela = Human(n: "Angela Yu")
        let jack = Human(n: "Jack Bauer")
        let nemo = Fish(n: "Nemo")

        let neighbours = [angela, jack, nemo]

        func findNemo(from animals: [Animal]){
            for animal in animals {
                        //Type Check
                if animal is Fish {
                    print(animal.name)
                }
            }
        }

        //Type Check
        if (neighbours[0] is Human){
            print("First Neighbour is a Human")
        }
        
    - `!` forced downcasting
        
            func findNemo(from animals: [Animal]){
                for animal in animals {
                    if animal is Fish {
                        //forced downcasting
                        let fish = animal as! Fish
                        fish.breathUnderWater()
                    }
                }
            }
            
        - `?` check if it is availbe for `fish`,  데이터 타입이 downcasting이 될 수 있는지 확인해준다.
        
                if let fish = neighbours[1] as? Fish {
                    fish.breathUnderWater()
                } else {
                    print("Casting has failed")
                }
        
        - `as` -> Upcasting
        
                let animalFish = fish as Animal

- Any, AnyObject, NSObject
    - any : It encompasses all objects, basically `any data type`
    
            let angela:Human = Human(n: "Angela Yu")
            let jack:Human = Human(n: "Jack Bauer")
            let nemo:Fish = Fish(n: "Nemo")
            let num:Int = 12

            //Any
            let neighbours:[Any] = [angela, jack, nemo, num] //원래는 이렇게 다른 타입의 데이터가 같은 어레이에 있을 수 없다

    - AnyObject -> AnyObject: Object created from `class`

    - NSObject -> NSObject: Object created from `foundation`
    
- Store Data - Firestore
    - Firestore (More features, e.g. cloud firestore)
    - Realtime Database (JSON DB)
        
            @IBAction func sendPressed(_ sender: UIButton) {
                if  let mesasgeBody = messageTextfield?.text,
                    let messageSender = Auth.auth().currentUser?.email {
                    
                    db.collection(K.FStore.collectionName).addDocument(data: [
                        K.FStore.senderField: messageSender,
                        K.FStore.bodyField: mesasgeBody
                    ]){ (error) in
                        if let e = error {
                            print("There was an issue saving data to firestore, \(e)")
                        } else {
                            print("Successfully saved data.")
                        }
                    }
                    
                }
            }

- Retrieve data - Firestore

            func loadMessages() {
                
                db.collection(K.FStore.collectionName).addSnapshotListener { (querySnapshot, error) in
                    
                    self.messages = []
                    
                    if let e = error {
                        print("There was an issue retrieving data from Firestore. \(e)")
                    } else {
                        if let snapshotDocuments = querySnapshot?.documents {
                            for doc in snapshotDocuments {
                                let data = doc.data()
                                if  let sender = data[K.FStore.senderField] as? String, //Dictionary
                                    let messageBody = data[K.FStore.bodyField] as? String //Dictionary
                                {
                                    let newMessage = Message(sender: sender, body: messageBody)
                                    
                                    self.messages.append(newMessage)
                            
                                    DispatchQueue.main.async {
                                        self.tableView.reloadData()
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }

- Listen for realtime updates
    - addDocument대신, addSnapshotListener를 붙이면, 데이터가 바뀔 때마다 실시간으로 업데이트 된다

        
            func loadMessages() {
                
                db.collection(K.FStore.collectionName).addSnapshotListener { (querySnapshot, error) in
                    
                    self.messages = []
                    
                    if let e = error {
                        print("There was an issue retrieving data from Firestore. \(e)")
                    } else {
                        if let snapshotDocuments = querySnapshot?.documents {
                            for doc in snapshotDocuments {
                                let data = doc.data()
                                if  let sender = data[K.FStore.senderField] as? String, //Dictionary
                                    let messageBody = data[K.FStore.bodyField] as? String //Dictionary
                                {
                                    let newMessage = Message(sender: sender, body: messageBody)
                                    
                                    self.messages.append(newMessage)
                            
                                    DispatchQueue.main.async {
                                        self.tableView.reloadData()
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
        
- How to manage the keyboard and use the swift package manager
    - The library you use must have `package.swift` file to use `swift package manage`
    
            func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                    // Override point for customization after application launch.
                    FirebaseApp.configure()
                    Firestore.firestore()
                    IQKeyboardManager.shared.enable = true
                    IQKeyboardManager.shared.enableAutoToolbar = false
                    IQKeyboardManager.shared.shouldResignOnTouchOutside = true
                    
                    return true
            }

- UI Improvement
    - Automatic Scroll
    - Customize Navigation bar
    
    - android 에서 따지면 onBindViewHolder에서 어떤 유저인지에 따라서 메시지를 다르게 보여준다
    
            extension ChatViewController: UITableViewDataSource {
                
                func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                    return messages.count
                }
                
                func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                    //Data Binding
                    let message = messages[indexPath.row]
                    let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
                    cell.label.text = message.body
                    
                    //This is a message from the current user
                    if message.sender == Auth.auth().currentUser?.email {
                        cell.leftImageView.isHidden = true
                        cell.rightImageView.isHidden = false
                        cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
                    } else {
                        cell.rightImageView.isHidden = false
                        cell.rightImageView.isHidden = true
                        cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.blue)
                    }
                    

                    
                    return cell
                }
                
            }
        
        - automatic scroll
        
                self.tableView.reloadData()
                let indexPath: IndexPath = IndexPath(row: self.messages.count - 1, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)

        - 전체
        
                func loadMessages() {
                    
                    db
                        .collection(K.FStore.collectionName)
                        .order(by: K.FStore.dateField)
                        .addSnapshotListener { (querySnapshot, error) in
                        
                        self.messages = []
                        
                        if let e = error {
                            print("There was an issue retrieving data from Firestore. \(e)")
                        } else {
                            if let snapshotDocuments = querySnapshot?.documents {
                                for doc in snapshotDocuments {
                                    let data = doc.data()
                                    if  let sender = data[K.FStore.senderField] as? String, //Dictionary
                                        let messageBody = data[K.FStore.bodyField] as? String //Dictionary
                                    {
                                        let newMessage = Message(sender: sender, body: messageBody)
                                        
                                        self.messages.append(newMessage)
                                
                                        DispatchQueue.main.async {
                                            self.tableView.reloadData()
                                            let indexPath: IndexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                        }
                                        
                                    }
                                }
                            }
                        }
                    }
                }

- Navigation Control in `ViewController`
    - ! it's always good to use `super.method()` whenever you override the method from `super class`

        import UIKit

            class WelcomeViewController: UIViewController {

                @IBOutlet weak var titleLabel: UILabel!
                
                override func viewWillAppear(_ animated: Bool) {
                    super.viewWillAppear(animated)
                    navigationController?.isNavigationBarHidden = true
                }
                
                override func viewWillDisappear(_ animated: Bool) {
                    super.viewWillDisappear(animated)
                    navigationController?.isNavigationBarHidden = false
                }
                
                override func viewDidLoad() {
                    super.viewDidLoad()
                    
                    titleLabel.text = ""
                    var charIndex:Double = 0
                    let titleText = K.appName
                    for letter in titleText {
                        Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false, block: {(timer) in
                            self.titleLabel.text?.append(letter)
                        })
                        charIndex += 1
                    }
                        
                }

                
            }
            
- Swift LifeCycle

            //
            //  ViewController.swift
            //  LifeCycle
            //
            //  Created by shin seunghyun on 2020/02/13.
            //  Copyright © 2020 shin seunghyun. All rights reserved.
            //

            import UIKit

            class ViewController: UIViewController {

                override func viewDidLoad() {
                    super.viewDidLoad()
                    // Do any additional setup after loading the view.
                }

                override func viewWillAppear(_ animated: Bool) {
                    super.viewWillAppear(animated)
                }
                
                override func viewDidAppear(_ animated: Bool) {
                    super.viewDidAppear(animated)
                }
                
                override func viewWillDisappear(_ animated: Bool) {
                    super.viewWillDisappear(animated)
                }
                
                override func viewDidDisappear(_ animated: Bool) {
                    super.viewDidDisappear(animated)
                }

            }


- SceneDelegate.swift , for lifecycle

            //
            //  SceneDelegate.swift
            //  LifeCycle
            //
            //  Created by shin seunghyun on 2020/02/13.
            //  Copyright © 2020 shin seunghyun. All rights reserved.
            //

            import UIKit

            class SceneDelegate: UIResponder, UIWindowSceneDelegate {

                var window: UIWindow?


                func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
                    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
                    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
                    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
                    guard let _ = (scene as? UIWindowScene) else { return }
                }

                func sceneDidDisconnect(_ scene: UIScene) {
                    // Called as the scene is being released by the system.
                    // This occurs shortly after the scene enters the background, or when its session is discarded.
                    // Release any resources associated with this scene that can be re-created the next time the scene connects.
                    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
                }

                func sceneDidBecomeActive(_ scene: UIScene) {
                    // Called when the scene has moved from an inactive state to an active state.
                    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
                }

                func sceneWillResignActive(_ scene: UIScene) {
                    // Called when the scene will move from an active state to an inactive state.
                    // This may occur due to temporary interruptions (ex. an incoming phone call).
                }

                func sceneWillEnterForeground(_ scene: UIScene) {
                    // Called as the scene transitions from the background to the foreground.
                    // Use this method to undo the changes made on entering the background.
                }

                func sceneDidEnterBackground(_ scene: UIScene) {
                    // Called as the scene transitions from the foreground to the background.
                    // Use this method to save data, release shared resources, and store enough scene-specific state information
                    // to restore the scene back to its current state.
                }


            }

20.02.12

- Thrid Party Library

        sudo gem install cocoapods

        pod setup --verbose

        pod --version

        pod init
        
-  Podfile

        platform :ios, '13.0'

        target 'Flash Chat iOS13' do
          use_frameworks!

          # Pods for Flash Chat iOS13

          pod 'CLTypingLabel'  #새로 추가할 module

        end

- Implemenation

        import UIKit
        import CLTypingLabel //

        class WelcomeViewController: UIViewController {

            @IBOutlet weak var titleLabel: CLTypingLabel!
            
            override func viewDidLoad() {
                super.viewDidLoad()
                
                titleLabel.text = "⚡️FlashChat"
                    
            }
            
        }
        
- Cocoa Pod

        platform :ios, '13.0'

        target 'Flash Chat iOS13' do
          use_frameworks!

          # Pods for Flash Chat iOS13

        end
        
- NavigationController


        @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
            
            let firebaseauth = Auth.auth()
            do {
                try firebaseauth.signOut()
                navigationController?.popToRootViewController(animated: true)
                
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
            
        }
        
- AppBar Handle

        override func viewDidLoad() {
               super.viewDidLoad()
               title = "⚡️FlashChat"
               navigationItem.hidesBackButton = true
        }
        
- Using a Constants File and Understanding the static keyword

        struct K {
            static let appName = "⚡️FlashChat"
            static let cellIdentifier = "ReusableCell"
            static let cellNibName = "MessageCell"
            static let registerSegue = "RegisterToChat"
            static let loginSegue = "LoginToChat"
            
            struct BrandColors {
                static let purple = "BrandPurple"
                static let lightPurple = "BrandLightPurple"
                static let blue = "BrandBlue"
                static let lighBlue = "BrandLightBlue"
            }
            
            struct FStore {
                static let collectionName = "messages"
                static let senderField = "sender"
                static let bodyField = "body"
                static let dateField = "date"
            }
        }
        
- how to access it

        let titleText = K.appName
        
- Table View
    - Table View Cell
    - Table View Controller
    - iOS의 recyclerview
    
            import UIKit
            import Firebase
            
            class ChatViewController: UIViewController {
                
                let firebaseauth = Auth.auth()
            
                @IBOutlet weak var tableView: UITableView!
                @IBOutlet weak var messageTextfield: UITextField!
                
                var messages: [Message] = [
                    Message(sender:"1@2.com", body: "Hey!"),
                    Message(sender:"a@b.com", body: "Hello!"),
                    Message(sender:"1@2.com", body: "What's up?"),
                ]
                
                override func viewDidLoad() {
                    super.viewDidLoad()
                    tableView.dataSource = self
                    title = K.appName
                    navigationItem.hidesBackButton = true
                }
                
                @IBAction func sendPressed(_ sender: UIButton) {
                }
                
                @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
                    
                    do {
                        try firebaseauth.signOut()
                        navigationController?.popToRootViewController(animated: true)
                        
                    } catch let signOutError as NSError {
                        print("Error signing out: %@", signOutError)
                    }
                    
                }
                
            }
            
            extension ChatViewController: UITableViewDataSource {
                
                func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                    return messages.count
                }
                
                func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                    let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
                    cell.textLabel?.text = messages[indexPath.row].body
                    return cell
                }
                
            }
            
            //Click Event Handler
            extension ChatViewController: UITableViewDelegate {
                func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                    print(indexPath.row)
                }
            }

20.02.10

- function as a parameter
        
        func calculator(n1: Int, n2: Int, operation: (Int, Int) -> Int) -> Int {
            return operation(n1, n2)
        }

        func add(no1: Int, no2: Int) -> Int {
            return no1 + no2
        }

        let result = calculator(n1: 7, n2: 3, operation: add)
        
- closure - anonymous function

        func calculator(n1: Int, n2: Int, operation: (Int, Int) -> Int) -> Int {
            return operation(n1, n2)
        }

        calculator(n1: 4, n2: 5, operation: { (no1: Int, no2: Int) -> Int in
            return no1 * no2
        })
        
- withoout datatype

        func calculator(n1: Int, n2: Int, opeartion: (Int, Int) -> Int) -> Int {
            return opeartion(n1, n2)
        }

        let result = calculator(n1: 2, n2: 3, opeartion: { (no1, no2) -> Int in 
         return no1 * no2 
        })

- in one line

        func calculator(n1: Int, n2: Int, opeartion: (Int, Int) -> Int) -> Int {
            return opeartion(n1, n2)
        }

        let result = calculator(n1: 2, n2: 3, opeartion: { (no1, no2) -> Int in no1 * no2 })
        
- anonymous parameter names using $  $0 → first parameter, $1 → second parameter

        func calculator(n1: Int, n2: Int, opeartion: (Int, Int) -> Int) -> Int {
            return opeartion(n1, n2)
        }
        
        let result = calculator(n1: 2, n2: 3, opeartion: { $0 * $1 })
        
- Map
    -❗️Swift에서 closure function 내부에 있는 내용이 함수에 접근하려면 self keyword를 붙여야 한다.

        let array = [1, 2, 3, 4, 5, 6]

        func addOne(n1: Int) -> Int {
                return n1 + 1
        }

        let normalArray = array.map(addOne)

        let newStringArray = array.map({"\($0)"})
        let newPlusArray = array.map({(n1:Int) -> Int in n1 + 1})


- SF Symbol
    - cloud.bolt 식으로 이름이 주어짐
    
            //Computed Properties
            var conditionName: String {
                switch conditionId {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                case 801...804:
                    return "cloud.bolt"
                default:
                    return "cloud"
                }
            }

-SF Symbol 사용하는 방식

         self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        
- Computed Properties

            

20.02.09
- dark mode를 고려해서 제품을 만들 것

- Delegate Design Pattern
    - 내 식으로 풀어서 얘기하자면, 특정 protocol을 공유하는 것 중에 super class 또는 struct가 아래의 object에게 일을 위임함
    

                //Cetificate
                protocol AdvancedLifeSupport {
                    func performCPR()
                }

                class EmergencyCallHandler {
                    var delegate: AdvancedLifeSupport?
                    
                    func assessSituation(){
                        print("Can you tell me what happened?")
                    }
                    
                    func medicalEmergency(){
                        delegate?.performCPR()
                    }

                }

                struct Paramedic: AdvancedLifeSupport {
                    
                    init(handler: EmergencyCallHandler){
                        handler.delegate = self
                    }
                    
                    func performCPR() {
                        print("The paramedic does chest compressions, 30 per second.")
                    }
                }

                class Doctor: AdvancedLifeSupport {
                    
                    init(handler: EmergencyCallHandler) {
                        handler.delegate = self
                    }
                    
                    func performCPR() {
                        print("The doctor does chest compressions, 30 per second.")
                    }
                    
                    func useStethescope() {
                        print("Listening for heart sounds")
                    }
                    
                }

                class Surgeon: Doctor {
                    override func performCPR() {
                        super.performCPR()
                        print("Sings staying alive by the BeeGees")
                    }
                }

                let emilio = EmergencyCallHandler()
                let angela = Surgeon(handler: emilio)

                emilio.assessSituation()
                emilio.medicalEmergency()


- Delegate가 적용된 swift iOS 예시

            import UIKit

            class WeatherViewController: UIViewController, UITextFieldDelegate {

                @IBOutlet weak var conditionImageView: UIImageView!
                @IBOutlet weak var temperatureLabel: UILabel!
                @IBOutlet weak var cityLabel: UILabel!
                @IBOutlet weak var searchTextField: UITextField!

                var weatherManager:WeatherManager = WeatherManager()
                
                override func viewDidLoad() {
                    super.viewDidLoad()
                    searchTextField.delegate = self //이 부분이 delegate 부분이다
                }


                @IBAction func searchPressed(_ sender: UIButton) {
                    searchTextField.endEditing(true)
                    print(searchTextField.text!)
                }

                // User Pressed Return Button on Keyboard
                func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                    searchTextField.endEditing(true)
                    print(searchTextField.text!)
                    return true
                }

                // User Input Validation
                func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
                    if(textField.text != ""){
                        return true
                    } else {
                        textField.placeholder = "Type something"
                        return false
                    }
                }

                // User Stopped Editing
                func textFieldDidEndEditing(_ textField: UITextField) {

                    if let city = searchTextField.text {
                        weatherManager.fetchWeather(cityName: city)
                    }

                    searchTextField.text = ""
                }

            }

- Swift HTTP 통신 기본

            import Foundation

            struct WeatherManager {

                let weatherURL: String = "https://api.openweathermap.org/data/2.5/weather";
                let apiKey: String = "2a50132195767631db0cdfe509d8af9f"

                func fetchWeather(cityName: String) {
                    let urlString: String = "\(weatherURL)?q=\(cityName)&appid=\(apiKey)"
                    performRequest(urlString: urlString)
                }

                func performRequest(urlString: String) {

                    //1. create URL
                    if let url: URL = URL(string: urlString) {

                        //2. create a URLSession
                        let session: URLSession = URLSession(configuration: .default)

                        //3. Give the session a task
                        let task: URLSessionDataTask = session.dataTask(with: url, completionHandler: handle)

                        //4. Start the task
                        task.resume()

                    }

                }

                func handle(data: Data?, response: URLResponse?, error: Error?) {

                    if (error != nil) {
                        print(error!)
                        return
                    }

                    if let safeData: Data = data {
                        let dataString: String = String(data: safeData, encoding: .utf8)
                        print(dataString!)
                    }

                }

            }

- Computed Properties

            struct WeatherModel {
                let conditionId: Int
                let cityName: String
                let temperature: Double

                var temperatureString: String {
                    String(format: "%.1f", temperature)
                }

                //Computed Properties
                var conditionName: String {
                    switch conditionId {
                    case 200...232:
                        return "cloud.bolt"
                    case 300...321:
                        return "cloud.drizzle"
                    case 500...531:
                        return "cloud.rain"
                    case 600...622:
                        return "cloud.snow"
                    case 701...781:
                        return "cloud.fog"
                    case 800:
                        return "sun.max"
                    case 801...804:
                        return "cloud.bolt"
                    default:
                        return "cloud"
                    }
                }


            }
            
- Type Alias

            typealias Codable = Decodable & Encodable
            
- Parameter Names, external - internal 

            func myFunc(name: Type) {
                print(name)
            }
                
- DispatchQueue
    
            func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
                //UI에 데이터를 곧바로 업데이트 할 수 없다. => 안드로이드와 비슷함. Main Thread만 UI View에 접근할 수 있다.
                //Background로 UI를 update 해야한다.
                DispatchQueue.main.async { //closure
                    self.temperatureLabel.text = weather.temperatureString
                }
            }

- Extensions

            import UIKit

            extension Double {
                
                func round(to places: Int) -> Double {
                    let precisionNumber = pow(10, Double(places))
                    var n = self
                    n = n * precisionNumber
                    n.round()
                    n = n / precisionNumber
                    return n
                }
                
            }

            var myDouble = 3.14159

            myDouble.round(to: 3)
            
            
            import UIKit

            //let button = UIButton(frame: CGRect(x:0, y:0, width:50, height:50))
            //button.backgroundColor = .red
            //button.layer.cornerRadius = 25
            //button.clipsToBounds = true

            extension UIButton {
                func makeCircular(){
                    self.clipsToBounds = true
                    self.layer.cornerRadius = self.frame.size.width / 2
                }
            }

            let button = UIButton(frame:CGRect(x: 0, y: 0, width: 50, height: 50))
            button.backgroundColor = .red
            button.makeCircular()
            
- protocol extension

            protocol CanFly {
                    func fly()
            }

            extension CanFly {
                    func fly(){
                            print("The object takes off into the air")
                    }
            }
            
- extension을 이용한 코드 분할

            //
            //  ViewController.swift
            //  Clima
            //
            //  Created by Angela Yu on 01/09/2019.
            //  Copyright © 2019 App Brewery. All rights reserved.
            //

            import UIKit

            class WeatherViewController: UIViewController {

                @IBOutlet weak var conditionImageView: UIImageView!
                @IBOutlet weak var temperatureLabel: UILabel!
                @IBOutlet weak var cityLabel: UILabel!
                @IBOutlet weak var searchTextField: UITextField!

                var weatherManager: WeatherManager = WeatherManager()

                override func viewDidLoad() {
                    super.viewDidLoad()
                    weatherManager.delegate = self
                    searchTextField.delegate = self
                }

            }

            //Mark: - UITextFieldDelegate

            extension WeatherViewController: UITextFieldDelegate {

                @IBAction func searchPressed(_ sender: UIButton) {
                    searchTextField.endEditing(true)
                    print(searchTextField.text!)
                }


                // User Pressed Return Button on Keyboard
                func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                    searchTextField.endEditing(true)
                    print(searchTextField.text!)
                    return true
                }

                // User Input Validation
                func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
                    if (textField.text != "") {
                        return true
                    } else {
                        textField.placeholder = "Type something"
                        return false
                    }
                }

                // User Stopped Editing
                func textFieldDidEndEditing(_ textField: UITextField) {
                    if let city = searchTextField.text {
                        weatherManager.fetchWeather(cityName: city)
                    }
                    searchTextField.text = ""
                }

            }

            extension WeatherViewController: WeatherManagerDelegate {

                func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
                    //UI에 데이터를 곧바로 업데이트 할 수 없다. => 안드로이드와 비슷함. Main Thread만 UI View에 접근할 수 있다.
                    //Background로 UI를 update 해야한다.
                    DispatchQueue.main.async { //closure
                        self.temperatureLabel.text = weather.temperatureString
                        self.conditionImageView.image = UIImage(systemName: weather.conditionName)
                    }
                }

                func didFailWithError(error: Error) {
                    print(error)
                }

            }
            
- location

            import UIKit
            import CoreLocation

            class WeatherViewController: UIViewController {

                @IBOutlet weak var iconImageView: UIImageView!
                @IBOutlet weak var temperatureLabel: UILabel!
                @IBOutlet weak var cityLabel: UILabel!
                @IBOutlet weak var searchTextField: UITextField!

                var weatherManager: WeatherManager = WeatherManager()
                let locationManager: CLLocationManager = CLLocationManager()

                override func viewDidLoad() {
                    super.viewDidLoad()
                    locationManager.delegate = self
                    locationManager.requestWhenInUseAuthorization()
                    locationManager.requestLocation()

                    weatherManager.delegate = self
                    searchTextField.delegate = self
                }

                @IBAction func updateWeatherButtonPressed(_ sender: UIButton) {
                    locationManager.requestLocation()
                }
                
            }

            extension WeatherViewController: CLLocationManagerDelegate {
                public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                    if let location = locations.last {
                        locationManager.stopUpdatingLocation()
                        let lat = location.coordinate.latitude
                        let lon = location.coordinate.longitude
                        weatherManager.fetchWeather(latitude: lat, longitude: lon)
                    }
                }

                public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
                    print(error)
                }
            }

20.02.07

- print two decimal point

        String(format: "%2.f", value)

- no decimal point

        String(format: "%.0f", value)

- no decimal point

        Int(value)
        
- square number

        let bmi:Float = weight / pow(height, 2)

- override method
    - 굳이 super.method()를 호출하지 않아도 된다.
    - super class에서 정의된 method가 필요 없다는 뜻이다.

            override func move() {
                    print("Fly forwards")
                }
                
            override func attack() {
                super.attack()
                print("Spits Fire, does 10 damage")
            }

- struct vs class
        - struct can't inherit
        - class is passed by reference
        - class can copy 
        
    - `use structures by default`
    - use classes when you need Objective-C interporlability
    - use `classes` when you need to control `the identity of the data` you're modeling
    - use structures along with protocols to adopt behavior by sharing implementations
        
- multiple screen default

        let secondVC = SecondViewController()
        secondVC.bmiValue = String(format: "%.1f", bmi)
        self.present(secondVC, animated: true, completion: nil)

- multiple screen segue way
        
    - 첫 번째 화면
    - segue에 id값을 준 뒤에
    -  `self.performSegue(withIdentifier: "goToResult", sender: self)
    - 보내줄 값이 있으면 `override prepare` 
    
            import UIKit

            class CalculateViewController: UIViewController {

                @IBOutlet weak var heightLabel: UILabel!
                @IBOutlet weak var weightLabel: UILabel!
                @IBOutlet weak var heightSlider: UISlider!
                @IBOutlet weak var weightSlider: UISlider!

                var bmiValue:Float = 0
                
                override func viewDidLoad() {
                    super.viewDidLoad()
                    // Do any additional setup after loading the view.
                }

                @IBAction func heightSliderChanged(_ sender: UISlider){
                    heightLabel.text = String(format: "%.1f", sender.value) + "m"
                }
                
                @IBAction func weightSliderChanged(_ sender: UISlider) {
                    weightLabel.text = String(format: "%.0f", sender.value) + "Kg"
                }
                
                @IBAction func calculatePressed(_ sender: UIButton) {
                    let height:Float = heightSlider.value
                    let weight:Float = weightSlider.value
                    
                    let bmi:Float = weight / pow(height, 2)
                    bmiValue = bmi
                    
                    //화면 넘기기
                    self.performSegue(withIdentifier: "goToResult", sender: self)
                }
                
                //화면 넘기기 전에 보내줄 데이터를 initialize
                override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                    //Safety Check.
                    if (segue.identifier == "goToResult") {
                        let destinationVC = segue.destination as! ResultViewController //Down Casting
                        destinationVC.bmiValue = String(format: "%.1f", bmiValue) //다음 화면에 있는 value
                    }
                }
                

            }
            
    - 두 번째 화면, 받는 값
    
            import UIKit

            class ResultViewController: UIViewController {
                
                var bmiValue: String? //nil일 수도 있기 때문에 optional 값을 준다.

                @IBOutlet weak var bmiLabel: UILabel!
                @IBOutlet weak var adviceLabel: UILabel!
                
                override func viewDidLoad() {
                    super.viewDidLoad()
                    if(bmiValue != nil){
                        bmiLabel.text = bmiValue
                    }
                }
                
                @IBAction func recalculatePressed(_ sender: UIButton) {
                    self.dismiss(animated: true, completion: nil)
                }


            }
            
- Swift Downcasting

            
            let destinationVC = segue.destination as! ResultViewController //이렇게 해줘야 다음 화면의 변수에 값을 지정해줄 수 있다.
            
            
- Optional Deep
        
    -1. Unrwap
            
            value!
        
    -2. check for nil value
    
        if(value != nil){
            value!
        }

    -3. Optional Binding
    
        if let safeValue = optional {
            safeValue
        }

    -4. optional ?? default
    
        value ?? defaultValue
        
    -5. Optional Chaining (for class and structure)
        
        optional?.property
        optional?.method()    //If this optional isn't `nil`, continue

20.02.06

- Structure

        struct Town {

            let name = "ShinLand"
            var citizens = ["Shin", "Jack Bauer"]
            var resources = ["Grain": 100, "Ore": 42, "Wool": 75]
            
            func fortify(){
                print("Defences increased!")
            }

        }

- initializer

        struct Town {
            let name : String
            var citizens : [String]      //Array
            var resources : [String:Int] //Dictionary
            
            init(name: String, citizens: [String], resources: [String:Int]){
                    self.name = name
                    self.citizens = citizens
                    self.resources = resources
            }
        
            func fortify(){
                    print("Defences Increased!")
            }
        
        }
        
        var anotherTown = 
        Town(
        townName: "Nameless Island", 
        people: ["Tom Hanks"], 
        stats: ["Coconuts": 100]
        )
        
- Delay

        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)

        @objc func updateUI() {
                questionLabel.text = quiz[questionNumber].question
                trueButton.backgroundColor = UIColor.clear
                falseButton.backgroundColor = UIColor.clear
            }
            
- Quiz Game

            import UIKit

            class ViewController: UIViewController {

                @IBOutlet weak var questionLabel: UILabel!
                @IBOutlet weak var progressBar: UIProgressView!
                @IBOutlet weak var trueButton: UIButton!
                @IBOutlet weak var falseButton: UIButton!

                let quiz = [
                    Question(q: "A slug's blood is green.", a: "True"),
                    Question(q: "Approximately one quarter of human bones are in the feet.", a: "True"),
                    Question(q: "The total surface area of two human lungs is approximately 70 square metres.", a: "True"),
                    Question(q: "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.", a: "True"),
                    Question(q: "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.", a: "False"),
                    Question(q: "It is illegal to pee in the Ocean in Portugal.", a: "True"),
                    Question(q: "You can lead a cow down stairs but not up stairs.", a: "False"),
                    Question(q: "Google was originally called 'Backrub'.", a: "True"),
                    Question(q: "Buzz Aldrin's mother's maiden name was 'Moon'.", a: "True"),
                    Question(q: "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.", a: "False"),
                    Question(q: "No piece of square dry paper can be folded in half more than 7 times.", a: "False"),
                    Question(q: "Chocolate affects a dog's heart and nervous system; a few ounces are enough to kill a small dog.", a: "True")
                ]

                var questionNumber = 0
                var totalQuestion = 0

                override func viewDidLoad() {
                    super.viewDidLoad()

                    totalQuestion = quiz.count

                    updateUI()
                }

                @IBAction func answerButtonPressed(_ sender: UIButton) {

                    let userAnswer = sender.currentTitle!
                    let actualAnswer = quiz[questionNumber].answer

                    if (userAnswer == actualAnswer) {
                        sender.backgroundColor = UIColor.green
                    } else {
                        sender.backgroundColor = UIColor.red
                    }

                    if (questionNumber < quiz.count - 1) {
                        questionNumber += 1
                    } else {
                        questionNumber = 0
                        progressBar.setProgress(0, animated: true)
                    }

                    Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)

                }


                @objc func updateUI() {
                    questionLabel.text = quiz[questionNumber].question
                    trueButton.backgroundColor = UIColor.clear
                    falseButton.backgroundColor = UIColor.clear

                    let progressValue : Float = Float(questionNumber + 1) / Float(totalQuestion)
                    progressBar.setProgress(progressValue, animated: true)
                    print("\(progressValue) : current value")
                }

            }


- Parameter name not required

            func checkAnswer(_ userAnswer: String){
                            
            }
            
- Internal - External Parameter

            func checkAnswer(answer userAnswer: String){
                    //userAnswer이란 parameter name으로 접근 가능 
                    //answer - external parameter
                    //userAnswer - internal parameter 
            }

- return 값이 있는 함수

            func checkAnswer(_ userAnswer: String) -> Bool {

                if (userAnswer == quiz[questionNumber].answer) {
                    return true
                } else {
                    return false
                }

            }

- struct 내부의 변수 값 변경


            //mutating
            mutating func increment(){
                if(questionNumber + 1 < quiz.count){
                    questionNumber += 1
                } else {
                    questionNumber = 0
                }
            }

20.02.05

- Linking multiple elements to one IBAction


- Function insdie of Function

        func greeting1(){
            print("Hello")
            
            func greeting2(){
                print("Hey")
            }

        }
        
- Linking multiple elements to a single action
    -@IB, interface connection part
    -기본적으로 swift element들에 여러가지 property에 접근할 수 있다.
        -example)
            
        sender.titleLabel.text
    
        @IBAction func keyPressed(_ sender: UIButton) {
            
            print(sender.titleLabel?.text);
            
            playSound()
            
        }
        
- Type Differences
    - input
    - swift specific grammer: `func myFunction(parameter: DataType){ }`


- Play Sound

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

- Creating Function
        
            var myAge:Int = 12
        
            func getMilk(bottles int){
                var cost = bottles * 1.5
            }
        
- Call Function

            getMilk(bottles: 2);

- String interpretatoin

            func greeting(whoToGreet: String){
                print("Hello \(whoToGreet)");
            }
            
            gretting(whoToGreet: "Anyone");
            
- current title
            
            note: sender.currentTitle!
            
- alpha color

            sender.imageView?.backgroundColor?.withAlphaComponent(0.5)
            
- Swift switch Statement
"Swift는 `switch`를 사용할 때, `break` keyword가 필요가 없다."

                let score = Int.random(in: 0...100)

                switch score {
                    case 81...100:

                    case 41..<81:

                    case ...40:

                    default


                }

- Dictionary

                let eggtimes = ["Soft" : 5, "Medium" : 7, "Hard" : 12]


=> Dictionary 사용 전

                import UIKit

                class ViewController: UIViewController {
                    
                    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 9]

                    @IBAction func eggClicked(_ sender: UIButton) {
                        
                        let hardness = sender.currentTitle
                        
                            
                        switch hardness {
                        case "Soft":
                            print(eggTimes["Soft"]!);
                        case "Medium":
                            print(eggTimes["Medium"]!);
                        case "Hard":
                            print(eggTimes["Hard"]!);
                        default: break
                        
                        }
                        
                        
                    }
                    
                }

=> Dictionary 적용 후

                import UIKit

                class ViewController: UIViewController {
                    
                    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]

                    var secondsRemaining = 60;

                   
                    @IBAction func eggClicked(_ sender: UIButton) {
                        let hardness = sender.currentTitle!
                        secondsRemaining = eggTimes[hardness]!
                        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true);
                    }
                    
                    @objc func updateTimer(){
                        if secondsRemaining > 0 {
                            print("\(secondsRemaining) seconds.")
                            secondsRemaining -= 1
                        }
                        
                    }
                }
                
- Optionals
    - `?`는 nil 값을 허용
    
              var player1UserName : String? = nil
    
    -`!`는 optional을 unwrap 해준다.
    
            var unwrappedP1Username = player1Username!  
        
    - safety check
    
            if player1Username != nil {
                print(player1Username!);
            }
            
    

- Timer Version 1

import UIKit

    class ViewController: UIViewController {
        
        let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]

        var secondsRemaining = 60;

       
        @IBAction func eggClicked(_ sender: UIButton) {
            let hardness = sender.currentTitle!
            secondsRemaining = eggTimes[hardness]!
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true);
        }
        
        @objc func updateTimer(){
            if secondsRemaining > 0 {
                print("\(secondsRemaining) seconds.")
                secondsRemaining -= 1
            }
            
        }
    }

- Timer Version 2

        import UIKit

        class ViewController: UIViewController {
            
            let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]

            @IBOutlet weak var textLabel: UILabel!
            var secondsRemaining = 60;
            var timer = Timer();
            
            @IBAction func eggClicked(_ sender: UIButton) {
                    textLabel.text = "How do you like your eggs?"
                timer.invalidate()
                let hardness = sender.currentTitle!
                secondsRemaining = eggTimes[hardness]!
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            }
            
            @objc func updateTimer(){
                if secondsRemaining > 0 {
                    print("\(secondsRemaining) seconds.")
                    secondsRemaining -= 1
                } else {
                    timer.invalidate();
                    textLabel.text = "done";
                }
            }
        }
        
- Timer Version 3

        import UIKit

        class ViewController: UIViewController {
            
            @IBOutlet weak var textLabel: UILabel!
            @IBOutlet weak var progressView: UIProgressView!
            
            var timer = Timer();
            let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720];
            var totalTime = 0;
            var secondPassed = 0;
            
            @IBAction func eggClicked(_ sender: UIButton) {
                textLabel.text = "How do you like your eggs?";
                timer.invalidate();
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
                }
            }
        }

- Timer Version4

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

20.02.04

- Size `Classes` and `Orientation`
- Undestand `Constraints`
- Learn about `Alignment` and `Pinning`
- Use `Containers` for more fine grained control
- Learn about `StackViews` 

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
