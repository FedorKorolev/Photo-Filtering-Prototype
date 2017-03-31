//
//  AlbumCreator.swift
//  Photo Filtering Prototype
//
//  Created by Фёдор Королёв on 31.03.17.
//  Copyright © 2017 Фёдор Королёв. All rights reserved.
//

import Photos

struct AlbumCreator {
    
    static func createAlbum(with title: String, assets: [PHAsset]) {
        
        var placeholder: PHObjectPlaceholder?
        PHPhotoLibrary.shared().performChanges({
            let request = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: title)
            placeholder = request.placeholderForCreatedAssetCollection
        }, completionHandler: { (success, error) -> Void in
            if success {
                if let id = placeholder?.localIdentifier {
                    let fetchResult = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [id],
                                                                              options: nil)
                    if let album = fetchResult.firstObject {
                        PHPhotoLibrary.shared().performChanges( {
                        let albumChangeRequest = PHAssetCollectionChangeRequest(for: album, assets: fetchResult as! PHFetchResult<PHAsset>)
                            albumChangeRequest?.addAssets(assets as NSFastEnumeration) },
                                                               completionHandler: nil)
                        
                    }
                }
            }
        })
    }
    
}
