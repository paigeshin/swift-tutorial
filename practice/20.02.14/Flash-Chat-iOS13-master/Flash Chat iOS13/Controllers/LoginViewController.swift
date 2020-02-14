import UIKit
import Firebase

class LoginViewController: UIViewController {

    let TAG: String = "LoginViewController"
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    let firebaseAuth:Auth = Auth.auth()

    @IBAction func loginPressed(_ sender: UIButton) {
        if  let email: String = emailTextfield.text,
            let password: String = passwordTextfield.text {
            firebaseAuth.signIn(withEmail: email, password: password) { (result, error ) in
                if let registerError:Error = error {
                    print("\(self.TAG) - loginPressed(): Error happened while registering user - \(registerError)")
                } else {
                    self.performSegue(withIdentifier: K.loginToChat, sender: self)
                }
            }
        }
    }

}
