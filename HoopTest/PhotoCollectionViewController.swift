//
//  PhotoCollectionViewController.swift
//  HoopTest
//
//  Created by Guedria Khaled on 18/08/2019.
//  Copyright © 2019 Guedria Khaled. All rights reserved.
//

import UIKit

//All photos collection
class PhotoCollectionViewController: UIViewController {

    //Widgets
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //var
    
    //show View
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //Actions
    
    //Go to AddForm
    @IBAction func AddPhoto(_ sender: Any) {
        performSegue(withIdentifier: "AddPhotoSegue", sender: sender)
    }
    
    //Show imageDetails

    
}
