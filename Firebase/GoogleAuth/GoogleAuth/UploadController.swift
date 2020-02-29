//
//  UploadController.swift
//  GoogleAuth
//
//  Created by shin seunghyun on 2020/02/27.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase

class UploadController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var subject: UITextField!
    @IBOutlet weak var explanation: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openGallery))) //Listener를 달은 것임
        imageView.isUserInteractionEnabled = true
        
    }
    
    @objc func openGallery() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = pickedImage
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func uploadButtonPressed(_ sender: UIButton) {
        upload(pickedImage: imageView.image!)
    }
    
    func upload(pickedImage: UIImage){
        
        if let data = pickedImage.jpegData(compressionQuality: 0.1) {
            
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
                            Database.database().reference().child("users").childByAutoId().setValue([
                                "userId": Auth.auth().currentUser?.email,
                                "uid": Auth.auth().currentUser?.uid,
                                "subject": self.subject.text!,
                                "explanation": self.explanation.text!,
                                "imageUrl": downloadURL,
                                "imageName": fileImageName
                            ])
                        }
                        
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
        
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
