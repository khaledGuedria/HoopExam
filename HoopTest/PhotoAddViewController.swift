//
//  PhotoAddViewController.swift
//  HoopTest
//
//  Created by Guedria Khaled on 18/08/2019.
//  Copyright © 2019 Guedria Khaled. All rights reserved.
//

import UIKit
import Firebase
import CoreData

class PhotoAddViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    //Widgets
    @IBOutlet weak var uploadedPhoto: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //var
    var cdsize = 0
    
    //Show View
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCoreDateSize()
        self.activityIndicator.isHidden = true
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
        
        print("Save button pressed !")
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
                
        let storage = Storage.storage()
        var data = Data()
        data = self.uploadedPhoto.image!.jpegData(compressionQuality: 0.8)! 
         //create storage reference
         let storageRef = storage.reference()

        let imageRef = storageRef.child("images/" + String(self.cdsize + 1) + ".png")
        _ = imageRef.putData(data, metadata: nil,completion: { (metadata,error) in
         
            if error != nil {
            print(error!)
            return
         
            }
            
            imageRef.downloadURL(completion: {url, error in
                
                if error != nil {
                    print("Failed to download url:", error!)
                    return
                }
                
                //save it to CoreData
                self.saveUrlToCoreData(url: url!)
                //redirect to image collection
                self.performSegue(withIdentifier: "returnToCollectionSegue", sender: sender)
                
            })
         
         })
        


    }
    
    //Add photo url to coredata
    func saveUrlToCoreData(url:URL) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "FirePhoto", in: managedContext)
        let Image = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        Image.setValue(url, forKey: "img_url")
        print("saved to coredata successfully !")

        appDelegate.saveContext()
        
    }
    
    //get coredata size
    func getCoreDateSize(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FirePhoto")
        
        do {
            
            cdsize = try (managedContext.fetch(request) as! [NSManagedObject]).count
            
        } catch  let error as NSError{
            print(error.userInfo)
        }
    }
    
    
	}
