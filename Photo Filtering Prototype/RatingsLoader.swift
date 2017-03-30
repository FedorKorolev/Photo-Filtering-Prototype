//
//  RatingsLoader.swift
//  Photo Filtering Prototype
//
//  Created by Nikolay Shubenkov on 30/03/2017.
//  Copyright © 2017 Фёдор Королёв. All rights reserved.
//

import Foundation
import Photos

class RatingsLoader {
    
    static var shared:RatingsLoader = RatingsLoader()
    
    lazy var ratings:[PhotoRating] = self.loadRatings()
    
    func saveRatings(){
        let ratingsToStore = self.ratings.map{ $0.toDict() }
        UserDefaults.standard.set(ratingsToStore, forKey: "ratings")
    }
    
    private func loadRatings()->[PhotoRating]
    {
        let ratings:[ [String:Any] ] = UserDefaults.standard.array(forKey: "ratings") as? [ [String:Any] ] ?? []
        
        return ratings.flatMap{ PhotoRating(dict:$0) }
    }
    
}
