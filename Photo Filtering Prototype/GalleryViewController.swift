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
    var filteredAssets = [PHAsset]()
    
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateFilteredResults()
    }
    
    func updateFilteredResults(){
        if ratingLoader.filter.hasAtLeastOnePoint {
            filteredAssets = ImagesLoader.assets(assets: assets,
                                                 filteredBy: ratingLoader.filteredResults.keys.map{ $0 })
        }
        else {
            filteredAssets = assets
        }
        collectionView.reloadData()
    }
}

extension GalleryViewController: RatingControlDelegate {
    
    func control(_ control: RatingControl, changeRatingTo rating: Int) {
        
        switch control
        {
        case starRatingControl:  ratingLoader.filter.stars = rating
            
        case likeRatingControl:  ratingLoader.filter.likes = rating
        
        case circleRatingControl: ratingLoader.filter.circles = rating
            
        default: fatalError("wrong view was pressed")
        }
        
        updateFilteredResults()
    }
}

// Collection View Data Source
extension GalleryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredAssets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCell
        let asset = filteredAssets[indexPath.row]
        let image = ImagesLoader.loadImage(from: asset, width: cell.bounds.width * 2, height: cell.bounds.height * 2, highQuaility: false)
        cell.imageView.image = image
        return cell
    }
}

// Navigation
extension GalleryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selected = filteredAssets[indexPath.row]
    
        performSegue(withIdentifier: "Show Photo View", sender: selected)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? PhotoViewController,
            let photo = sender as? PHAsset {
            destVC.photo = photo
            destVC.rating = ratingLoader.ratingOf(assetId: photo.localIdentifier)
        }
    }
}




