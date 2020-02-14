import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    let TAG:String = "ChatViewController"

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!

    let firebaseAuth: Auth = Auth.auth()
    let db: Firestore = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        title = K.appTitle
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadMessage()
    }
    
    func loadMessage(){
        db
            .collection(K.FireStore.collectionName)
            .order(by: K.FireStore.date)
            .addSnapshotListener { documentSnapshot, error in
                self.messages = []
                if let readError:Error = error {
                    print("\(self.TAG) - loadMessage(): \(readError)")
                } else {
                    if let snapshotDocuments = documentSnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if
                                let sender = data[K.FireStore.sender] as? String,
                                let body = data[K.FireStore.message] as? String,
                                let date = data[K.FireStore.date] as? TimeInterval {
                                
                                let newMessage = Message(sender: sender, body: body, date: date)
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
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let userEmail: String = firebaseAuth.currentUser?.email, let message: String = messageTextfield.text {
            var ref: DocumentReference? = nil
            ref = db.collection(K.FireStore.collectionName).addDocument(data: [
                K.FireStore.sender: userEmail,
                K.FireStore.message: message,
                K.FireStore.date: Date().timeIntervalSince1970
            ]) { err in
                if let err = err {
                    print("\(self.TAG) - sendPressed(UIBUTTON) - Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                    
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                    
                }
            }
        }
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("\(TAG) - logoutButtonPrssed(UIBarButtonItem) : \(signOutError)")
        }
        
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.messageLabel.text = message.body
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
        } else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.blue)
        }
        return cell
    }
}
