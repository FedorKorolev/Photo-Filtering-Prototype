//
//  ImagesLoader.swift
//  Photo Filtering Prototype
//
//  Created by Фёдор Королёв on 29.03.17.
//  Copyright © 2017 Фёдор Королёв. All rights reserved.
//

import Photos

struct ImagesLoader {
    
    static func loadAssets() -> [PHAsset] {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.includeAssetSourceTypes = .typeUserLibrary
        
        let fetchResults = PHAsset.fetchAssets(with: fetchOptions)
        var assets = [PHAsset]()
        fetchResults.enumerateObjects(using: {(object: AnyObject, count: Int, stop: UnsafeMutablePointer) in
            assets.append(object as! PHAsset)
        })
        return assets
    }
    
        
    static func loadImage(from asset: PHAsset, width: CGFloat, height: CGFloat) -> UIImage {
        
        var loadedImage = UIImage()
        
        PHImageManager.default().requestImage(for: asset,
                                              targetSize: CGSize(width: width, height: height),
                                              contentMode: .aspectFit,
                                              options: nil) { (image, _) -> Void in
                                                loadedImage = image!
        }
        
        
        return loadedImage
    }
}
