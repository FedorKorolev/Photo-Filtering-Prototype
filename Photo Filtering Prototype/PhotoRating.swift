//
//  PhotoRating.swift
//  Photo Filtering Prototype
//
//  Created by Nikolay Shubenkov on 30/03/2017.
//  Copyright © 2017 Фёдор Королёв. All rights reserved.
//

import Foundation

struct PhotoRating {
    let photoId:String
    var stars = 0
    var likes = 0
    var circles = 0
    
    
    init?(dict:[String : Any]){
        guard let id = dict["id"] as? String,
            let stars = dict["stars"] as? Int,
            let likes = dict["likes"] as? Int,
            let circles = dict["circles"] as? Int else {
                return nil
        }
        
        self.photoId = id
        self.stars = stars
        self.likes = likes
        self.circles = circles
    }
    
    func toDict()->[String:Any]{
        return ["id" : self.photoId,
                "stars" : self.stars,
                "likes":self.likes,
                "circles":self.circles]
    }    
}
