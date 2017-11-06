//
//  MainVC.swift
//  PicSearch
//
//  Created by Rambo on 2017-10-31.
//  Copyright © 2017 Rami Baraka. All rights reserved.
//

import UIKit


class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var collectionController: UICollectionView!
    @IBOutlet weak var inputField: UITextField!
    
    let reuseIdentifier = "PicCell"
    var pics = [FlickrPic]();
    let picService = PicService()
    
    var screenSize: CGRect!
    var screenWidth, screenHeight: CGFloat!
    
    override func viewDidLoad(){

        super.viewDidLoad()
        // Sets up the collection view
        collectionController.delegate = self
        collectionController.dataSource = self
        
        // Gets screen size used for the layout creation
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        // Sets the layout for the collection view
        collectionController!.collectionViewLayout = createLayout()
        collectionController.isHidden = true
        
        // Sets this ViewController as the UITextfieldDelegate in order to use the Enter key to search
        inputField.delegate = self

    }
    
    
    // Changes the style of the status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // Sets the search function to the textfield's enter/search key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        search()
        return true
    }
    
    // Starts the search
    func search(){
        
        // Makes sure that the inputfield is not empty
        if(inputField.text != ""){
            // Displays the loading modal
            waitAlert()
            // Gets the text to search for
            let searcFrase = inputField.text!
            // Makes network request and sets the data to a local variable then displays the list
            self.picService.getPics(searchWord: searcFrase, finished: {
                pics in
                self.pics = pics
                self.collectionController.reloadData()
                self.collectionController.setContentOffset(CGPoint(x:0,y:0), animated: true)
                self.collectionController.isHidden = false
                // Dismisses the loading modal
                self.dismiss(animated: false, completion: nil)
            })
        }
    }
    
    //Creates an activity indicator and sets up a loading modal
    func waitAlert(){
        let alert = UIAlertController(title: nil, message: "Searching..", preferredStyle: .alert)
        
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.startAnimating();
        
        alert.view.addSubview(indicator)
        present(alert, animated: false, completion: nil)
    }
    
    // Creates a Layout for the collectionView
    func createLayout()-> UICollectionViewLayout{
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        return layout
    }
    
    // Tells the collection view how many items there are
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pics.count   }
    
    // Sets up each collectionview cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pic = self.pics[indexPath.row]
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PicCell {
            cell.configureCell(pic: pic)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    // Prepares the segue by passing the object to display to the recieveng view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UICollectionViewCell,
            let indexPath = collectionController.indexPath(for: cell) {
            let vc = segue.destination as! DetailVC
            vc.pic = pics[indexPath.row] as FlickrPic
        }
    }
    
    // Segues to the detail screen
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Detail", sender: nil)
    }
    

}

