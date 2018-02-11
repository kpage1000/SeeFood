//
//  ViewController.swift
//  SeeFood
//
//  Created by Kenin Page on 2/11/18.
//  Copyright © 2018 Kenin Page. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad() 

        imagePicker.delegate = self
        imagePicker.sourceType = .camera  //when using on simulator you will need to use the .photoLobrary option instead of .camera
        imagePicker.allowsEditing = false //if you want to crop then you may want to allow editing
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let userPickedImpage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = userPickedImpage
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        present (imagePicker, animated: true, completion: nil)
        
    }
    
}

