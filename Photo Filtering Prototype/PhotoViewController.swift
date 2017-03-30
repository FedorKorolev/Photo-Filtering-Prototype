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
        
        // load image
        imageView.image = ImagesLoader.loadImage(from: selected["asset"]! as! PHAsset,
                                                 width: imageView.bounds.width,
                                                 height: imageView.bounds.height)
        
        // load rating from storage
        arrayOfRatingDicts = defaults.value(forKey: "arrayOfRatingDicts") as! [[String : Int]]
        print("Rating Loaded\n \(arrayOfRatingDicts)")
        
        // load index as int
        index = selected["index"] as! Int
    }
    
    // Properties
    let defaults = UserDefaults.standard
    
    var arrayOfRatingDicts = [[String : Int]]()
    
    var selected  = [String : Any]()
    var index = Int()
    
    
    // Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func starPressed(_ sender: UIButton) {
        arrayOfRatingDicts[index]["stars"]! += 1
        saveRating()
    }
    
    @IBAction func likePressed(_ sender: UIButton) {
        arrayOfRatingDicts[index]["likes"]! += 1
        saveRating()
    }
    
    @IBAction func circlePressed(_ sender: UIButton) {
        arrayOfRatingDicts[index]["circles"]! += 1
        saveRating()
    }
    
    // Save rating to storage
    func saveRating() {
        defaults.set(arrayOfRatingDicts, forKey: "arrayOfRatingDicts")
        print("Rating Updated and Saved")
        print(defaults.value(forKey: "arrayOfRatingDicts") as! [[String : Int]])
    }

}
