//
//  ViewController.swift
//  CollectionView
//
//  Created by shin seunghyun on 2020/02/23.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    let images = [#imageLiteral(resourceName: "image5"), #imageLiteral(resourceName: "image6"), #imageLiteral(resourceName: "image7")]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //이미지 카운터하는 Function
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RowCell", for: indexPath) as! CustomCell
        cell.imageView.image = images[indexPath.row]
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        //각 셀의 크기
//        let width = collectionView.frame.width / 3
//        //        let height = collectionView.frame.height / 3
//        return CGSize(width: width, height: width)
//
//    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let kWhateverHeightYouWant = 100
        return CGSize(width: collectionView.bounds.size.width, height: CGFloat(kWhateverHeightYouWant))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //컬랙션뷰 행 하단 여백
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        //컬렉션뷰 컬럼 사이 여백
        return 0
    }
    
    
    
    
}

class CustomCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
}
