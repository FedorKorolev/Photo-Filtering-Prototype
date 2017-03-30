//
//  GalleryViewController.swift
//  Photo Filtering Prototype
//
//  Created by Фёдор Королёв on 28.03.17.
//  Copyright © 2017 Фёдор Королёв. All rights reserved.
//

import Photos

class GalleryViewController: UIViewController {

    // Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set icons
        likeRatingControl.iconName = "Like"
        circleRatingControl.iconName = "Circle"
        
        // load assets
        assets = ImagesLoader.loadAssets()
    
        // load defaults
        let defaults = UserDefaults.standard
        
        // check stored rating
        let array = defaults.value(forKey: "arrayOfRatingDicts") as? [[String : Int]]
        if (array?.isEmpty)! {
            for _ in assets {
                arrayOfRatingDicts.append(["stars" : 0,
                                           "likes" : 0,
                                           "circles": 0
                    ])
            }
            defaults.set(arrayOfRatingDicts, forKey: "arrayOfRatingDicts")
            print("Rating Initialized\n \(arrayOfRatingDicts)")
        } else {
            arrayOfRatingDicts = array!
            print("Rating Loaded\n \(arrayOfRatingDicts)")
        }
        
        // Setup collection
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    // Assets Data
    var assets = [PHAsset]()
    
    // Rating Dictionary
    var arrayOfRatingDicts = [[String : Int]]()
    
    
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




