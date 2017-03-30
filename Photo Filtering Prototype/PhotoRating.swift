//
//  PhotoRating.swift
//  Photo Filtering Prototype
//
//  Created by Nikolay Shubenkov on 30/03/2017.
//  Copyright © 2017 Фёдор Королёв. All rights reserved.
//

import Foundation

struct PhotoRating {
    private let maxValue = 5
    
    let photoId:String
    var stars = 0    {  didSet {  if stars > maxValue { stars = 0 }  }  }
    var likes = 0    {  didSet {  if likes > maxValue { likes = 0 }  }  }
    var circles = 0  {  didSet {  if circles > maxValue { circles = 0 }  }  }
    
    var hasAtLeastOnePoint:Bool {
        return stars + likes + circles > 0
    }
    
    init?(dict:[String : Any], id:String){
        guard let stars = dict["stars"] as? Int,
            let likes = dict["likes"] as? Int,
            let circles = dict["circles"] as? Int else {
                return nil
        }
        
        self.photoId = id
        self.stars = stars
        self.likes = likes
        self.circles = circles
    }
    
    init(){
        photoId = ""
        stars = 0
        likes = 0
        circles = 0
    }
    
    func toDict()->[String:Int]{
        return ["stars" : self.stars,
                "likes" : self.likes,
                "circles":self.circles]
    }
    
    func ratingIsSameAsIn(otherRating:PhotoRating)->Bool
    {
        return stars == otherRating.stars &&
        likes == otherRating.likes &&
        circles == otherRating.circles
    }
}
