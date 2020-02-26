//
//  ViewController.swift
//  HowlMapkit
//
//  Created by shin seunghyun on 2020/02/26.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    
    @IBOutlet weak var mapKitView: MKMapView!
    //권한
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //화면 찍을 위치
        let location = CLLocationCoordinate2D(latitude: 37.392448, longitude: 126.638831)
        
        //화면 찍는 부분과 description 추가
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Central Park"
        annotation.subtitle = "공원"
        
        //확대하는 부분 코드
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.1)
        //확대할 위치
        let region = MKCoordinateRegion(center: location, span: span)
        mapKitView.setRegion(region, animated: true)
        
        //실제로 mark를 찍어줌
        mapKitView.addAnnotation(annotation)
     
        //자기 위치 찍기
        //Info.plist에 Privacy - Location Always and When In Use Usage Description 를 줘야한다.
        locationManager.requestWhenInUseAuthorization()
        mapKitView.showsUserLocation = true
        
    }


}

