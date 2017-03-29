//
//  RatedPhoto.swift
//  Photo Filtering Prototype
//
//  Created by Фёдор Королёв on 29.03.17.
//  Copyright © 2017 Фёдор Королёв. All rights reserved.
//

import UIKit

struct RatedPhoto {
    
    let image: UIImage
    
    var stars = 0
    var likes = 0
    var circles = 0
    
    init(image: UIImage) {
        self.image = image
    }
}
