//
//  PhotoAddViewController.swift
//  HoopTest
//
//  Created by Guedria Khaled on 18/08/2019.
//  Copyright © 2019 Guedria Khaled. All rights reserved.
//

import UIKit
import Firebase

class PhotoAddViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    //Widgets
    @IBOutlet weak var uploadedPhoto: UIImageView!
    
    
    //var

    //Show View
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Actions

    //Upload Action
    @IBAction func uploadAction(_ sender: Any) {
        
        let ImagePicker = UIImagePickerController()
        ImagePicker.delegate = self
        ImagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(ImagePicker, animated: true, completion: nil)
        
    }
    
    //imageViewpicker init
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage]
            as? UIImage else {
                return
        }
        
        uploadedPhoto.image = image
        dismiss(animated:true, completion: nil)
    }
    
    //Firebase Save
    @IBAction func saveAction(_ sender: Any) {
        
        
        let storage = Storage.storage()
        var data = Data()
        data = self.uploadedPhoto.image!.jpegData(compressionQuality: 0.8)! 
         //create storage reference
         let storageRef = storage.reference()
        let imageRef = storageRef.child("images/image.png")
        _ = imageRef.putData(data, metadata: nil,completion: { (metadata,error) in
         
            guard metadata != nil else {
            print(error!)
         return
         }

         
         })

        //performSegue(withIdentifier: "returnToCollectionSegue", sender: sender)
    }
    
    
	}
