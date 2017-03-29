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

    override func viewDidLoad() {
        super.viewDidLoad()
        likeRatingControl.iconName = "Like"
        circleRatingControl.iconName = "Circle"
        
        images = ImagesLoader.loadImages()
        
        collectionView.dataSource = self
    }

    var images = [UIImage]()
    
    @IBOutlet weak var starRatingControl: RatingControl!
    @IBOutlet weak var likeRatingControl: RatingControl!
    @IBOutlet weak var circleRatingControl: RatingControl!

    @IBOutlet weak var collectionView: UICollectionView!
   
    
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCell
        cell.imageView.image = images[indexPath.row]
        return cell
    }

    
}
