//
//  ViewController.swift
//  Privacy
//
//  Created by shin seunghyun on 2020/02/25.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //권한 받아오는 코드
        let camearaStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        
        if camearaStatus == .authorized {
            //승인
        } else if camearaStatus == .restricted {
            //일부 권한
        } else if camearaStatus == .notDetermined {
            //아직 물어보지 않음
        } else if camearaStatus == .denied {
            //거절 당함
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "권한", message: "카메라 권한을 받아오지 못했습니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        let albumStatus = PHPhotoLibrary.authorizationStatus()
        
        if albumStatus == .authorized {
            //승인
        } else if albumStatus == .restricted {
            //일부 권한
        } else if albumStatus == .notDetermined {
            //아직 물어보지 않음
        } else if albumStatus == .denied {
            //거절 당함
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "권한", message: "사진 권한을 받아오지 못했습니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func camera(_ sender: UIButton) {
        //카메라 여는 코드
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func album(_ sender: UIButton) {
        //앨범 여는 코드
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    //사진을 찍으면 여기 함수가 작동된다. 사진 정보를 받아올 수 있다. => 이미지가 찍혔을 때 작동되는 코드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func savePhoto(_ sender: UIButton) {
        
//        let imageData = UIImage.jpegData(self.imageView.image!)
//        let compressedImage = UIImage(data: imageData!)
        
        UIImageWriteToSavedPhotosAlbum(self.imageView.image!, nil, nil, nil)
        
    }
}

