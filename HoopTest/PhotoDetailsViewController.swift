//
//  PhotoDetailsViewController.swift
//  HoopTest
//
//  Created by Guedria Khaled on 18/08/2019.
//  Copyright © 2019 Guedria Khaled. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    //Widgets
    @IBOutlet weak var selectedImage: UIImageView!
    
    
    //var
    var photo_url:String?
    
    //show View
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getImageFromURL()
        // Do any additional setup after loading the view.
    }

    //Actions
    func getImageFromURL() {
        
        do {
            let imageSource = URL(fileURLWithPath: self.photo_url!)
            let imageData = try Data(contentsOf: imageSource)
            selectedImage.image = UIImage(data: imageData)
            
        } catch let error as NSError{
            print(error.userInfo)
        }

    }


}
