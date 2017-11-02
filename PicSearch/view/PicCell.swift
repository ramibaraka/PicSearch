//
//  PicCell.swift
//  PicSearch
//
//  Created by Rambo on 2017-10-31.
//  Copyright © 2017 Rami Baraka. All rights reserved.
//

import UIKit
import Kingfisher

class PicCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell(pic:FlickrPic){
        // Converts string to url
        let url = URL(string: pic.imgURL)
        
        // Sets loading indicator while image is downloaded
        self.imageView.kf.indicatorType = .activity
        
        // Downloads the image, caches it and sets it to the imageview with an animation
        self.imageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
    }
}




