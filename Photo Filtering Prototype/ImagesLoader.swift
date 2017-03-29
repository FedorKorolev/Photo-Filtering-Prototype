//
//  ImagesLoader.swift
//  Photo Filtering Prototype
//
//  Created by Фёдор Королёв on 29.03.17.
//  Copyright © 2017 Фёдор Королёв. All rights reserved.
//

import UIKit
import Photos

struct ImagesLoader {
    
    static func loadImages(width: CGFloat, height: CGFloat) -> [UIImage] {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        fetchOptions.includeAssetSourceTypes = .typeUserLibrary
        
        let fetchResults = PHAsset.fetchAssets(with: fetchOptions)
        var assets = [PHAsset]()
        fetchResults.enumerateObjects(using: {(object: AnyObject, count: Int, stop: UnsafeMutablePointer) in
            assets.append(object as! PHAsset)
        })
        
        var images = [UIImage]()
        
        for asset in assets {
            PHImageManager.default().requestImage(for: asset,
                                                  targetSize: CGSize(width: width, height: height),
                                                  contentMode: .aspectFill,
                                                  options: nil) { (image, _) -> Void in
                                                    images.append(image!)
            }
        }
        return images
        
    }

}
