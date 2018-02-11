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
            
            guard let ciImage = CIImage(image : userPickedImpage) else {
                fatalError("Cound not convert userPickedImage to CIImage")
            }
            
            detect(image : ciImage)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detect(image : CIImage) {
        guard let model = try? VNCoreMLModel(for : Inceptionv3().model) else {
            fatalError("Error loading CoreML model with CIImage")
        }
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model Failed to Process Image")
            }
            
            if let firstResult = results.first {
                if firstResult.identifier.contains("hotdog") {
                    self.navigationItem.title = "Hotdog!"
                } else {
                    self.navigationItem.title = "Not Hotdog!"
                }
            }
            
        }
        
        let handler = VNImageRequestHandler(ciImage : image)
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        present (imagePicker, animated: true, completion: nil)
        
    }
    
}

