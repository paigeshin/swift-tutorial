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

