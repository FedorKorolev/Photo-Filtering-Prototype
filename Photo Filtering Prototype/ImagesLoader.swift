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
    
    static func assets(assets:[PHAsset], filteredBy ids:[String])->[PHAsset]
    {
        if ids.count == 0 {
            return []
        }
        return assets.filter{ ids.contains($0.localIdentifier) }
    }
    
    static func loadImage(from asset: PHAsset, width: CGFloat, height: CGFloat, highQuaility:Bool) -> UIImage {
        
        var loadedImage = UIImage()
        
        let options = PHImageRequestOptions()
        options.version = PHImageRequestOptionsVersion.current
        options.deliveryMode =  highQuaility ? .highQualityFormat : .opportunistic
        options.resizeMode = PHImageRequestOptionsResizeMode.exact
        options.isNetworkAccessAllowed = false
        options.isSynchronous = true
        
        PHImageManager.default().requestImage(for: asset,
                                              targetSize: CGSize(width: width, height: height),
                                              contentMode: .aspectFill,
                                              options: options) { (image, _) -> Void in
                                                if let im = image {
                                                    loadedImage = im
                                                }
        }
        return loadedImage
    }
}
