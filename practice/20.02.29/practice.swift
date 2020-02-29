//서버없이 notification 달기 

import UserNotifications

//AppDelegate.swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let center = UNUserNotificationcenter.current()
    center.requestAuthorization(options: [.alert, .sound]) {(granted, error) in 
    
    }
    return true  
}

//UNUserNotificationCenterDelegate
class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad(){
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self 
    }

    @IBAction func notificationButton(_ sender: UIButton){

        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Hello!", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Hello_message_body", arguments: nil)
        content.sound = UNNotificationSound.default 
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)


    }

}




//Map Kit 

import UIKit
import MapKit 

class ViewController: UIViewController {

    @IBOutlet weak var mapKitView MKMapView!

    let locationManager = CLLocationManager()

    override func viewDidLoad(){
        super.viewDidLoad()

        let location = CLLocationCoordinate2D(latitude: 37.2323, longitude: 125.34324)
        let annotation = MKPointAnnotaion()
        annotation.coordinate = location 
        annotation.title = "Central Park"
        annotation.subtitle = "공원"

        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.1)
        let region: MKCoordinateRegion(center: location, span: span)
        mapKitView.setRegion(region, animated: true)

        mapKitView.addAnnotation(annotation)

        locationManager.requestWhenInUserAuthorization()
        mapKitView.showsUserLocation = true 

    }

}