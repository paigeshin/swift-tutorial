//
//  ViewController.swift
//  ScrollViewExample
//
//  Created by shin seunghyun on 2020/02/23.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //ViewPager
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let images = [#imageLiteral(resourceName: "image6"), #imageLiteral(resourceName: "background"), #imageLiteral(resourceName: "image5")]
        
        for i in 0..<images.count {
            let imageView = UIImageView()
            imageView.image = images[i]
            imageView.contentMode = .scaleAspectFit //이미지가 비율적으로 늘어남
            
            let xPosition = self.view.frame.width * CGFloat(i)
            //0, 0
            //100, 0
            //200, 0
            
            //CGRect은 좌표를 의미함
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.view.frame.width , height: self.view.frame.height)
            scrollView.contentSize.width = self.view.frame.width * CGFloat(1 + i)
            scrollView.addSubview(imageView)
            
        }
        
    }


}

