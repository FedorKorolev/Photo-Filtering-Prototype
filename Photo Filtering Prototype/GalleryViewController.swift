//
//  GalleryViewController.swift
//  Photo Filtering Prototype
//
//  Created by Фёдор Королёв on 28.03.17.
//  Copyright © 2017 Фёдор Королёв. All rights reserved.
//

import Photos

class GalleryViewController: UIViewController {

    // Outlets
    @IBOutlet weak var starRatingControl: RatingControl!
    @IBOutlet weak var likeRatingControl: RatingControl!
    @IBOutlet weak var circleRatingControl: RatingControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Assets Data
    var assets = [PHAsset]()
    
    // Rating Dictionary
    var ratingLoader = RatingsLoader.shared
    
    // Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set icons
        likeRatingControl.iconName = "Like"
        circleRatingControl.iconName = "Circle"
        
        [likeRatingControl,circleRatingControl,starRatingControl].forEach { $0.delegate = self }
        
        
        // load assets
        assets = ImagesLoader.loadAssets()
        
        // Setup collection
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension GalleryViewController: RatingControlDelegate {
    
    func control(_ control: RatingControl, changeRatingTo rating: Int) {
        
        switch control {
        case starRatingControl:
            ratingLoader.filter.
        default:
            <#code#>
        }
    }
    
}

// Collection View Data Source
extension GalleryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCell
        let asset = assets[indexPath.row]
        let image = ImagesLoader.loadImage(from: asset, width: cell.bounds.width * 2, height: cell.bounds.height * 2)
        cell.imageView.image = image
        return cell
    }
}

// Navigation
extension GalleryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selected = ["index" : indexPath.row,
                        "asset" : assets[indexPath.row]] as [String : Any]
    
        performSegue(withIdentifier: "Show Photo View", sender: selected)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? PhotoViewController,
            let selected = sender as? [String : Any] {
            destVC.selected = selected
        }

    }
}




