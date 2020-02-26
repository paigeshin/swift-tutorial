//
//  UserDTOTableViewCell.swift
//  AdvancedTableView
//
//  Created by shin seunghyun on 2020/02/23.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

class UserDTO {

    var imageString: String!
    var name: String!
    var message: String!
    
    init(imageString: String, name: String,message: String){
        self.imageString = imageString
        self.name = name
        self.message = message
    }
    
}
