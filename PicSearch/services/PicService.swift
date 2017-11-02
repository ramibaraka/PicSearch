//
//  PicService.swift
//  PicSearch
//
//  Created by Rambo on 2017-10-31.
//  Copyright © 2017 Rami Baraka. All rights reserved.
//
import Alamofire
import Foundation
import SwiftyJSON

class PicService {
    
    let API_KEY = "abbfa2e1646158947af37d22fcfc9356"
    let URL = "https://api.flickr.com/services/rest/"
    let PAGES = 210
    let METHOD = "flickr.photos.search"
    let FORMAT_TYPE:String = "json"
    let JSON_CALLBACK:Int = 1
    let PRIVACY_FILTER:Int = 1
    let EXTRAS = "url_q,url_z,url_o"


    func getPics(searchWord: String, finished: @escaping (_ pics:[FlickrPic]) ->Void) {
        
        // Makes the get request
        Alamofire.request(URL, parameters:  ["method": METHOD, "api_key": API_KEY, "per_page": PAGES, "text":searchWord,"privacy_filter":PRIVACY_FILTER, "format":FORMAT_TYPE, "nojsoncallback": JSON_CALLBACK,"extras":EXTRAS])
            .responseJSON { response in
                if(response.error == nil){
                    if let json = response.result.value {
                        
                        // Parses the jSon recieved in the response
                        let jSON = JSON(json)
                        let photoDiction = jSON["photos"]
                        let flickrArray = photoDiction["photo"]
                        var pics = [FlickrPic]()
                        
                        for pic in flickrArray  {
                            let id = pic.1["id"].stringValue
                            let farm = pic.1["farm"].stringValue
                            let server = pic.1["server"].stringValue
                            let secret = pic.1["secret"].stringValue
                            let title = pic.1["title"].stringValue
                            let imgURL = pic.1["url_q"].stringValue
                            var bigImgURL = pic.1["url_z"].stringValue
                            
                            // If there isnt a large image available this it sets it to the original size
                            if (bigImgURL == ""){
                                bigImgURL = pic.1["url_o"].stringValue
                            }
                            // Creates a model instance for each picture data recieved in response
                            let flickrPic = FlickrPic(id:id, title:title, farm:farm, secret: secret, server: server, imgURL: imgURL, bigImgURL: bigImgURL)
                            pics.append(flickrPic)
                        }
                        
                        // Returns the array of pic models with the finished callback
                        finished(pics)
                    }
                } else {
                    // Todo: Handle errors
                    print("There was an network error")
                }
                
        }
    }

}
