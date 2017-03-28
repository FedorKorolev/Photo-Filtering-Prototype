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
        
        collectionView.delegate = self
        
        reloadAssets()
    }

    @IBOutlet weak var starRatingControl: RatingControl!
    @IBOutlet weak var likeRatingControl: RatingControl!
    @IBOutlet weak var circleRatingControl: RatingControl!

    @IBOutlet weak var collectionView: UICollectionView!
   

    private func reloadAssets() {
        
    }
}

extension ViewController: UICollectionViewDelegate {
    
}
