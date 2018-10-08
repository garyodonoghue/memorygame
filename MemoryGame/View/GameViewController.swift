//
//  GameViewController.swift
//  MemoryGame
//
//  Created by Gary O'Donoghue on 06/10/2018.
//  Copyright © 2018 Gary O'Donoghue. All rights reserved.
//

import UIKit

/// View Controller used for displaying a collection view containing a number of 'cards', which the
/// user can select and turn over to reveal their image. The aim is to match the images on the cards
/// before the timer runs out
class GameViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    public var difficulty : Int?
    
    private let reuseIdentifier = "cardCell"
    private var images : [UIImage] = []
    private var gameTimer: Timer!
    private var memoryGameViewModel : MemoryGameViewModel?
    
    @IBOutlet weak var timerView : UIView!
    @IBOutlet weak var timeRemaining: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self;
        loadImages();
        
        timerView.frame = CGRect(x: self.collectionView.bounds.width/3, y: 700, width: self.collectionView.frame.size.width, height: 50)
        self.collectionView.addSubview(timerView)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        self.memoryGameViewModel = MemoryGameViewModel()
        self.memoryGameViewModel!.gameTimer = self.gameTimer
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.returnToMainMenu), name: Notification.Name("ReturnToMainMenu"), object: nil)
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return difficulty!;
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
        let gameFinished = memoryGameViewModel!.handleCardSelection(selectedCell: cell, difficulty: self.difficulty!)
        
        // if the game is finished, present a modal popup and save the user score in Core Date
        if(gameFinished){
            self.finishGame()
        }
    }
    

    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width/3-20, height: 100);
    }
    
    
    /// Make a series of calls to the Unsplash API using pre-defined image ids
    /// keep loading images until the number of images retrived = difficulty/2 (where difficulty is
    /// the overall number of cards in the game)
    func loadImages() {
        let imageIds = ["rW-I87aPY5Y", "l5truYNKmm8", "1l2waV8glIQ", "UPyadPLbCr8", "IbPxGLgJiMI", "zQrzlKQU2Ag", "dD75iU5UAU4", "Hd7vwFzZpH0", "0FQneB1VjaM"]
        let randomPhotoUrl = "https://source.unsplash.com/\(imageIds[self.images.count/2])/100x100"

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
                
                if(self.images.count == self.difficulty){
                    DispatchQueue.main.async {
                        self.memoryGameViewModel!.allImagesLoaded = true
                        self.loadingIndicator.stopAnimating()
                        self.collectionView.reloadData()
                    }
                }
                else {
                    self.loadImages()
                }
            }
        }
        
        task.resume()
    }
    
    
    /// Update the timer label - view model is responsible for returning updated value to be
    /// displayed
    @objc func updateTimer(){
        self.timeRemaining.text = memoryGameViewModel!.updateTimer()
        if(memoryGameViewModel!.gameOver){
            self.finishGame()
        }
    }
    
    /// The game is over, present a save score view to the user
    func finishGame(){
        let saveScoreViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SaveScoreViewController") as! SaveScoreViewController
        saveScoreViewController.memoryGameViewModel = self.memoryGameViewModel!
        saveScoreViewController.userScoreValue = self.memoryGameViewModel!.userScore
        self.present(saveScoreViewController, animated: true, completion: nil)
    }
    
    /// Return the user to the main menu, pop all view controllers in the stack
    @objc func returnToMainMenu(){
        self.navigationController?.popToRootViewController(animated: true)
    }
}
