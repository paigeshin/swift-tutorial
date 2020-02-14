import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    let TAG: String = "RegisterViewController"
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    let firebaseAuth:Auth = Auth.auth()
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if  let email: String = emailTextfield.text,
            let password: String = passwordTextfield.text {
            firebaseAuth.createUser(withEmail: email, password: password) { (result, error ) in
                if let registerError:Error = error {
                    print("\(self.TAG) - registerPressed(): Error Happend while registering user - \(registerError)")
                } else {
                    self.performSegue(withIdentifier: K.registerToChat, sender: self)
                }
            }
        }
    }
    
}
