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
    
    
    //ключем является айди фотографии
    lazy var ratings:[String:PhotoRating] = self.loadRatings()
    
    var filter:PhotoRating = PhotoRating() {
        didSet {
            //эта штука сбросит отфильтрованные результаты и когда мы к ним обратимся вновь - перезагрузит их
            _filteredResults = nil
        }
    }
    
    var filteredResults:[String:PhotoRating]{
        if _filteredResults != nil {
            return _filteredResults!
        }
        
        guard self.filter.hasAtLeastOnePoint else {
            _filteredResults = ratings
            return _filteredResults!
        }
        
        var filteredItems = [String:PhotoRating]()
        
        for (id,rating) in ratings {
            if rating.ratingIsSameAsIn(otherRating: filter){
                filteredItems[id] = rating
            }
        }
        
        _filteredResults = filteredItems
        return filteredItems
    }
    
    private var _filteredResults:[String:PhotoRating]?
    
    func ratingOf(assetId:String)->PhotoRating
    {
        var rating = ratings[assetId] ?? PhotoRating()
        rating.photoId = assetId
        return rating
    }
    
    func update(rating:PhotoRating)
    {
        defer { saveRatings() }
        
        guard rating.hasAtLeastOnePoint else {
            ratings[rating.photoId] = nil
            return
        }
        ratings[rating.photoId] = rating
    }
    
    func saveRatings(){

        var dict = [String:Any]()

        for (id,aRating) in self.ratings {
            dict[id] = aRating.toDict()
        }

        UserDefaults.standard.set(dict, forKey: "ratings")
    }
 
    private func loadRatings()->[String:PhotoRating]
    {
        guard let infoes:[String:Any] = UserDefaults.standard.dictionary(forKey: "ratings") else {
            return [:]
        }
        var ratings:[ String:PhotoRating ] = [:]
        
        for (photoId,value) in infoes {
            
            if let dict = value as? [String:Int] {
                
                ratings[photoId] = PhotoRating(dict: dict, id: photoId)
            }
        }
        return ratings
    }
    
}
