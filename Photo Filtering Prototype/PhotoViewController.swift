//
//  PhotoViewController.swift
//  Photo Filtering Prototype
//
//  Created by Фёдор Королёв on 29.03.17.
//  Copyright © 2017 Фёдор Королёв. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print(selectedPhotoIndex)
    }

    var selectedPhotoIndex = Int()
    
    @IBOutlet weak var imageView: UIImageView!
    
    

}
