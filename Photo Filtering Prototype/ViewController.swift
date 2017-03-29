//
//  ViewController.swift
//  Photo Filtering Prototype
//
//  Created by Фёдор Королёв on 28.03.17.
//  Copyright © 2017 Фёдор Королёв. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {

    // Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        likeRatingControl.iconName = "Like"
        circleRatingControl.iconName = "Circle"
        
        let images = ImagesLoader.loadImages()
        for image in images {
            ratedPhotos.append(RatedPhoto(image: image))
        }
        
        collectionView.dataSource = self
    }

    // Data
    var ratedPhotos = [RatedPhoto]()
    
    // Outlets
    @IBOutlet weak var starRatingControl: RatingControl!
    @IBOutlet weak var likeRatingControl: RatingControl!
    @IBOutlet weak var circleRatingControl: RatingControl!

    @IBOutlet weak var collectionView: UICollectionView!
   
    
}

// Collection View Data Source
extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ratedPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCell
        cell.imageView.image = ratedPhotos[indexPath.row].image
        return cell
    }
}


