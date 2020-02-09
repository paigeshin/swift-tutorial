//
//  ResultViewController.swift
//  Tipsy
//
//  Created by shin seunghyun on 2020/02/09.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var bill:String?
    var billDescription:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        billLabel.text = bill ?? "0.0"
        descriptionLabel.text = billDescription ?? ""
        
    }


    @IBAction func recalculateButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: false)
    }
}
