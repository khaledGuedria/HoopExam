//
//  PhotoCollectionViewController.swift
//  HoopTest
//
//  Created by Guedria Khaled on 18/08/2019.
//  Copyright © 2019 Guedria Khaled. All rights reserved.
//

import UIKit 
import CoreData
import Firebase

//All photos collection
class PhotoCollectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    //Widgets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var numLabel: UILabel!
    
    
    //var
    var images: [NSManagedObject] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.images.count)
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell")
        let contentView = cell?.viewWithTag(0)
        
        let imgView = contentView?.viewWithTag(1) as! UIImageView
        
        let image = images[indexPath.row]
        let imagesource = image.value(forKey: "img_url") as? URL

        do {
            let imageData = try Data(contentsOf: imagesource!)
            imgView.image = UIImage(data: imageData)
            
        } catch let error as NSError{
            print(error.userInfo)
        }

        return cell!
    }
    
    //..
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let persistentContainer = appDelegate.persistentContainer
            let managedContext = persistentContainer.viewContext
            
            let todelete = images[indexPath.row]
            managedContext.delete(todelete)
            
            let stringURL = todelete.value(forKey: "img_url") as! URL
            self.removeAction(url: stringURL)
            
            images.remove(at: indexPath.row)
            self.numLabel.text = String(images.count)
            tableView.reloadData()
        }
    }

    
    //show View
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchCoreDate()
        // Do any additional setup after loading the view.

    }
    
    //display image on full screen
    //send image url param
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let index = sender as? NSIndexPath
        
        if segue.identifier == "showDetailsSegue"{
            
            if let destinationViewController =  segue.destination as? PhotoDetailsViewController{
                
                print(index!)
                let image = images[index!.item]
                let url = image.value(forKey: "img_url") as! URL
                print(url)
                destinationViewController.photo_url = url
                
                
            }
        }
    }
    
    //Navigate to fullscreen
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailsSegue", sender: indexPath)
    }
    
    
    //Actions
    
    //REMOVE BY URL
    func removeAction(url:URL) {

        let storage = Storage.storage()
        let storageRef = storage.reference(forURL: url.absoluteString)
        //removing..
        storageRef.delete { error in
            if let error = error {
                print(error)
            }else {
                print("File deleted successfully !")
            }
            
        }
        
    }

    
    //GET ALL
    func fetchCoreDate(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FirePhoto")
        
        do {
            
            images = try managedContext.fetch(request) as! [NSManagedObject]
            self.numLabel.text = String(images.count)
            
        } catch  let error as NSError{
            print(error.userInfo)
        }
    }
    
    
    //Go to AddForm
    @IBAction func AddPhoto(_ sender: Any) {
        performSegue(withIdentifier: "AddPhotoSegue", sender: sender)
    }


    
}
