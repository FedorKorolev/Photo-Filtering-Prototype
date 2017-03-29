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
        
        let assets: [PHAsset] = ImagesLoader.loadAssets()
        for asset in assets {
            ratedAssets.append(RatedAsset(asset: asset))
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    // Assets Data
    var ratedAssets = [RatedAsset]()
    
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
        return ratedAssets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCell
        let asset = ratedAssets[indexPath.row].asset
        let image = ImagesLoader.loadImage(from: asset, width: cell.bounds.width * 2, height: cell.bounds.height * 2)
        cell.imageView.image = image
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




