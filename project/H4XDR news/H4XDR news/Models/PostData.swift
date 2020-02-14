//
//  PostData.swift
//  H4XDR news
//
//  Created by shin seunghyun on 2020/02/14.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

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
    let url: String?
    
}

