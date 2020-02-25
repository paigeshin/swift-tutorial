//
//  CustomNavigationSegue.swift
//  NavigationBar
//
//  Created by shin seunghyun on 2020/02/24.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

//세그 웨이가 여러개 있을 때 처리 => 마치 android의 fragement처럼 subview를 main 화면내에서 계속 바꿔준다.
class CustomNavigationSegue: UIStoryboardSegue {
    
    override func perform() {
        
        let viewController: ViewController = self.source as! ViewController
        //source를 ViewController로 casting 한다. `source`는 UIStoryboardSegue에서 들어옴.
        let destinationController: UIViewController = self.destination
        
        //이전 뷰를 제거해주는 코드
        for view in (viewController.frameView!.subviews) {
            view.removeFromSuperview()
        }
        
        //새로 들어온 view로 replace
        let childView: UIView = destination.view
        viewController.currentViewController = destinationController
        viewController.frameView.addSubview(childView)
        
        //크기 조정
        childView.translatesAutoresizingMaskIntoConstraints = false
        childView.topAnchor.constraint(equalTo: viewController.frameView.topAnchor).isActive = true
        childView.bottomAnchor.constraint(equalTo: viewController.frameView.bottomAnchor).isActive = true
        childView.leftAnchor.constraint(equalTo: viewController.frameView.leftAnchor).isActive = true
        childView.rightAnchor.constraint(equalTo: viewController.frameView.rightAnchor).isActive = true
        
    }
    
}
