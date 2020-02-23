//
//  ViewController.swift
//  TableViewPractice
//
//  Created by shin seunghyun on 2020/02/23.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let images = ["image1.jpg", "image2.jpg", "image3.jpg"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RowCell", for: indexPath) as! rowDTO
        cell.rowLabel.text = "Test"
        cell.rowImage.image = UIImage(named: images[indexPath.row])
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 10 //최소값
        
    }



}

class rowDTO: UITableViewCell {
    
    @IBOutlet weak var rowImage: UIImageView!
    @IBOutlet weak var rowLabel: UILabel!
    
}
