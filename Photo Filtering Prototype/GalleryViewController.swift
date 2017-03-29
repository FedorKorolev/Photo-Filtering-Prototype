//
//  GalleryViewController.swift
//  Photo Filtering Prototype
//
//  Created by Фёдор Королёв on 28.03.17.
//  Copyright © 2017 Фёдор Королёв. All rights reserved.
//

import UIKit
import Photos

class GalleryViewController: UIViewController {

    // Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        likeRatingControl.iconName = "Like"
        circleRatingControl.iconName = "Circle"
        
        let images = ImagesLoader.loadImages(width: 164, height: 164)
        for image in images {
            ratedPhotos.append(RatedPhoto(image: image))
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
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
extension GalleryViewController: UICollectionViewDataSource {
    
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

// Navigation
extension GalleryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPhotoIndex = indexPath.row
        performSegue(withIdentifier: "Show Photo View", sender: selectedPhotoIndex)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? PhotoViewController,
            let selectedPhotoIndex = sender as? Int {
            destVC.selectedPhotoIndex = selectedPhotoIndex
        }

    }
}




