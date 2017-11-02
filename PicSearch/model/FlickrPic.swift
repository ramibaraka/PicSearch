//
//  FlickrPic.swift
//  PicSearch
//
//  Created by Rambo on 2017-10-31.
//  Copyright © 2017 Rami Baraka. All rights reserved.
//

import Foundation

final class FlickrPic {
    
    var id: String
    var title: String
    var farm: String
    var secret: String
    var server: String
    var imgURL:String
    var bigImgURL:String
    
    init(id : String, title: String, farm: String, secret: String, server: String, imgURL:String, bigImgURL:String) {
        self.id = id
        self.title = title
        self.farm = farm
        self.secret = secret
        self.server = server
        self.imgURL = imgURL
        self.bigImgURL = bigImgURL
    }

    
}
