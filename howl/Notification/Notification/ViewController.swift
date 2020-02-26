//
//  ViewController.swift
//  Notification
//
//  Created by shin seunghyun on 2020/02/25.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let answer_1 = UNNotificationAction(identifier: "Good", title: "Lecture was great", options: [.foreground])
        let answer_2 = UNNotificationAction(identifier: "Not Good", title: "Lecture quality was poor", options: [.foreground])
        
        let category = UNNotificationCategory(identifier: "SelectBox", actions: [answer_1, answer_2], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        UNUserNotificationCenter.current().delegate = self
        
    }

    @IBAction func notificationButton(_ sender: UIButton) {
        
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Hello!", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Hello_message_body", arguments: nil)
        content.categoryIdentifier = "SelectBox"
        //Deliver the notification in five seconds
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        //Schedule the notification
        let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
        
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier {
        case "Good":
            label.text = "Lecture was Good"
        case "Not Good":
            label.text = "Lecture wasn't that bad"
        default:
            break
        }
        
    }
    
}

