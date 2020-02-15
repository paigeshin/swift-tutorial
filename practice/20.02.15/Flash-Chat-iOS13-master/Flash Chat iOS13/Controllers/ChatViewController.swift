//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    let TAG: String = "ChatViewController"
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    let auth:Auth = Auth.auth()
    let db:Firestore = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(TAG) - viewDidLoad() is called")
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadMessage()
    }
    
    func loadMessage(){
        print("\(TAG) - loadMessage() is called")
        db
            .collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener({ snapshots, error in
                self.messages = []
                if let error:Error = error {
                    print("\(self.TAG) - loadMessage(): \(error)")
                } else {
                    if let snapshots = snapshots?.documents {
                        for doc in snapshots {
                            let data = doc.data()
                            if let sender = data[K.FStore.senderField] as? String, let body = data[K.FStore.bodyField] as? String {
                                let newMessage = Message(sender: sender, body: body)
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
            })
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        print("\(TAG) - sendPressed(UIButton) is called")
        if let userEmail: String = auth.currentUser?.email, let message: String = messageTextfield.text {
            var ref: DocumentReference? = nil
            ref = db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: userEmail,
                K.FStore.bodyField: message,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]){ error in
                if let error = error {
                    print("\(self.TAG) - sendPressed(UIButton) - Error adding document: \(error)")
                } else {
                    print("\(self.TAG) - sendPressed(UIButton): Document added with ID - \(ref!.documentID)")
                }
            }
        }
        messageTextfield.text = ""
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        print("\(TAG) - logoutButtonPressed(UIBarButtonItem) is called")
        do {
            try auth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print("\(TAG) - logout Error happend: \(error)")
        }
    }
    
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(TAG) - tableView(UITableView, Int) is called")
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("\(TAG) - tableView(UITableView, IndexPath) is called")
        
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.messageLabel.text = message.body
        
        if message.sender == auth.currentUser?.email {
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
