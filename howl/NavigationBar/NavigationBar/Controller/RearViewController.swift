//
//  RearViewController.swift
//  NavigationBar
//
//  Created by shin seunghyun on 2020/02/24.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

class RearViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    let menus: [String] = ["공지사항", "게시판", "사진"]
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = menus[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationNavigation = segue.destination as! UINavigationController //UINavigation 가져오기
        let destinationViewController = destinationNavigation.topViewController as! ViewController //UINavigation에 가장 앞에 있는 화면을 가져오기. 이것을 해주려면 반드시 cell에다가 segueway를 등록해줘야함.
        
        destinationViewController.positionValue = menus[self.tableView.indexPathForSelectedRow!.row]
        
    }
    
    

}

