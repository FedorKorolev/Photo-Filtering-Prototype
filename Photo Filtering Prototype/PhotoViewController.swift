//
//  PhotoViewController.swift
//  Photo Filtering Prototype
//
//  Created by Фёдор Королёв on 29.03.17.
//  Copyright © 2017 Фёдор Королёв. All rights reserved.
//

import Photos

class PhotoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = ImagesLoader.loadImage(from: ratedAsset!.asset,
                                                 width: imageView.bounds.width,
                                                 height: imageView.bounds.height)
    }
    
    var ratedAsset: RatedAsset? = nil
    
    @IBOutlet weak var imageView: UIImageView!
    
    

}
