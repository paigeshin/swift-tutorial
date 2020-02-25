//
//  SecondViewController.swift
//  SegueWayDelegate
//
//  Created by shin seunghyun on 2020/02/25.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

protocol SecondViewProtocol {
    
    func setNewText(newText: String)
    
}

class SecondViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var textFromFirst: String?
    var delegate:SecondViewProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = textFromFirst!
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func closeButtonPressed(_ sender: UIButton) {
        delegate?.setNewText(newText: "User Logged Out")
        dismiss(animated: true, completion: nil)
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
