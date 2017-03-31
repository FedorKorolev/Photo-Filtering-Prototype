//
//  PhotoViewController.swift
//  Photo Filtering Prototype
//
//  Created by Фёдор Королёв on 29.03.17.
//  Copyright © 2017 Фёдор Королёв. All rights reserved.
//

import Photos

class PhotoViewController: UIViewController {

    @IBOutlet var starButton: UIButton!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var circleButton: UIButton!
    
    
    var photo:PHAsset!
    var rating:PhotoRating!
    var ratingLoader = RatingsLoader.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layoutIfNeeded()
        // load image
        imageView.image = ImagesLoader.loadImage(from: photo,
                                                 width: imageView.bounds.width * UIScreen.main.scale,
                                                 height: imageView.bounds.height * UIScreen.main.scale, highQuaility: true)
        
        // load rating from storage
        print("Rating Loaded\n \(rating)")
        updateButtons()
    }
    
    // Outlets and Actions
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func starPressed(_ sender: UIButton) {
        rating.stars += 1
        saveRatingAndUpdateUI()
    }
    
    @IBAction func likePressed(_ sender: UIButton) {
        rating.likes += 1
        saveRatingAndUpdateUI()
    }
    
    @IBAction func circlePressed(_ sender: UIButton) {
        rating.circles += 1
        saveRatingAndUpdateUI()
    }
    
    
    
    
    // Methods
    private func saveRatingAndUpdateUI(){
        ratingLoader.update(rating: rating)
        ratingLoader.saveRatings()
        updateButtons()
    }
    
    private func updateButtons(){
        update(button: starButton, with: rating.stars)
        update(button: likeButton, with: rating.likes)
        update(button: circleButton, with: rating.circles)
    }
    
    private func update(button:UIButton, with rating:Int)
    {
        button.titleLabel?.numberOfLines = 2
        let firstLne = button.currentTitle!.components(separatedBy: "\n").first!
        
        let additionalLine = "\n" + (rating > 0 ? "\(rating)" : "")
        button.setTitle(firstLne + additionalLine,
                        for: .normal)
    }
}
