//
//  DetailVC.swift
//  PicSearch
//
//  Created by Rambo on 2017-11-01.
//  Copyright © 2017 Rami Baraka. All rights reserved.
//

import UIKit
import Kingfisher



class DetailVC: UIViewController, UIScrollViewDelegate{
    
    var pic:FlickrPic!

    @IBOutlet weak var titelLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets the scrolling limit
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 2.0
        
        // Sets the image title
        titelLbl.text = pic.title
        
        // Converts the url string to a url
        let url = URL(string: pic.bigImgURL)
        
        // Sets loading indicator for while image is downloading
        self.imageView.kf.indicatorType = .activity
        
        // Uses kingfisher to download and cache the image and sets it to the imageview
        imageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
    }

    // Dismisses the detailview when close is tapped
    @IBAction func closeTouched(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    // Enables zoom for the provided view. In this case the stackview that holds the image, title and close button
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.stackView
    }

}
