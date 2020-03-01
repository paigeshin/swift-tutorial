//
//  ViewController.swift
//  remote_config
//
//  Created by shin seunghyun on 2020/03/01.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController {
    
    var remoteConfig: RemoteConfig!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.setDefaults(fromPlist: "FirebaseRemoteConfig")
        
        self.fetchConfig()
        DispatchQueue.main.async {
         
            self.displayMessage()
        }
        
    }
    
    func fetchConfig() {
        
        let remoteConfigSettings = RemoteConfigSettings()
        remoteConfig.configSettings = remoteConfigSettings
        
        remoteConfig.fetch(withExpirationDuration: 3600) { (state, error) in
            
            if state == .success {
                self.remoteConfig.activate { (error) in
                    if error != nil {
                        self.displayMessage()
                    }
                }
            }
            
        }
        
    }
    
    func displayMessage(){
        let message = remoteConfig["welcome_message"].stringValue
        let caps = remoteConfig["welcome_message_caps"].boolValue
        let color = remoteConfig["backgroundColor"].numberValue
        
        if caps {
            let alert = UIAlertController(title: "공지사항", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default) { (action) in
                exit(0)
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        if color == 1 {
            self.view.backgroundColor = UIColor.black
        }
    }
    
    
}

