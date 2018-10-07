//
//  GameViewController.swift
//  MemoryGame
//
//  Created by Gary O'Donoghue on 06/10/2018.
//  Copyright © 2018 Gary O'Donoghue. All rights reserved.
//

import UIKit

class GameViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let reuseIdentifier = "cardCell"
    private let selectedCards = 0
    private var images : [UIImage] = []
    private let difficulty = 6;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self;
        loadImages();
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return difficulty;
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CardCollectionViewCell
        
        // dont assign the images yet as they havent finished loading
        if let randomImage = self.images.randomElement(){
            cell.cardImage = randomImage
            images.remove(at: self.images.firstIndex(of: randomImage)!)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let cell = collectionView.cellForItem(at: indexPath as IndexPath) as! CardCollectionViewCell
        
        // don't do anything if this card has already been matched
        if(cell.isMatched){
            return
        }
        
        cell.flipCard()
    }
    

    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width/3-20, height: 150);
    }
    
    func loadImages() {
        let randomPhotoUrl = "https://source.unsplash.com/collection/190727/100x100"

        // Create NSURL Ibject
        let myUrl = URL(string: randomPhotoUrl);
        
        // Creaste URL Request
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        
        // Excute HTTP Request
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
            // Convert response to image
            if let image = UIImage(data: data!) {
                // append same image twice so that we can assign matching images when initializing
                // the collectionview cell images
                self.images.append(image)
                self.images.append(image)
            }
            
            if(self.images.count == self.difficulty){
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            else {
                self.loadImages()
            }
        }
        task.resume()
    }
}
