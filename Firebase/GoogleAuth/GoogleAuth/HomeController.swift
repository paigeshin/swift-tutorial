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
import FirebaseStorage

class HomeController: UIViewController {
    
    var uidKey: [String] = []
    var array: [UserDTO] = []
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Database.database().reference().child("users").observe(DataEventType.value) { (snapshot) in
            
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
                userDTO.imageName = dictionary["imageName"] as? String
                
                let uidKey = fChild.key
                
                self.array.append(userDTO)
                //자동으로 생성된 key값을 어레이에 담아준다.
                self.uidKey.append(uidKey)
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }

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
        
        //Thread를 돌려서 loading 속도를 더 빠르게 한다.
        URLSession.shared.dataTask(with: URL(string: array[indexPath.row].imageUrl!)!) { (data, response, error) in
            if error != nil {
                return
            }
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data!)
            }
        }.resume()
        
        
        cell.startButton.tag = indexPath.row
        cell.startButton.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
        
        //Firebase Database의 post 값이 특정 유저의 uid가 있는지 없는지 체크해준다.
        if let _ = self.array[indexPath.row].stars?[Auth.auth().currentUser!.uid]{
            //좋아요가 클릭도 있을 경우
            cell.startButton.setImage(#imageLiteral(resourceName: "baseline_favorite_black_18dp"), for: .normal)
        } else {
            cell.startButton.setImage(#imageLiteral(resourceName: "baseline_favorite_border_black_18dp"), for: .normal)
        }
        
        cell.deleteButton.tag = indexPath.row //테그를 참조하여 어떤 post를 지울지 정해줌
        cell.deleteButton.addTarget(self, action: #selector(deletePost(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func like(_ sender : UIButton){
        
//        if(sender.currentImage == #imageLiteral(resourceName: "baseline_favorite_black_18dp")){
//            sender.setImage(#imageLiteral(resourceName: "baseline_favorite_border_black_18dp"), for: .normal)
//        } else {
//            sender.setImage(#imageLiteral(resourceName: "baseline_favorite_black_18dp"), for: .normal)
//        }

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
    
    @objc func deletePost(_ sender: UIButton){
        
        Storage.storage().reference().child("ios_images").child(self.array[sender.tag].imageName!).delete { (error) in
            if(error != nil){
                print("Error occured while deleting")
            } else {
                Database.database().reference().child("users").child(self.uidKey[sender.tag]).removeValue()
            }
        }
        
    }
    
    
}

class CustomCell : UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var explanation: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
}
