//
//  CardCollectionViewCell.swift
//  MemoryGame
//
//  Created by Gary O'Donoghue on 06/10/2018.
//  Copyright © 2018 Gary O'Donoghue. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var currentCardView: UIImageView!
    
    private let backCardImage = UIImage(named: "card")
    var cardImage : UIImage = UIImage();
    
    var isShown: Bool = false
    var isMatched: Bool = false;
    
    func flipCard(){
        if(self.isShown){
            self.isShown = false;
            
            UIView.transition(with: self, duration: 1, options: UIView.AnimationOptions.transitionFlipFromLeft, animations: {
                self.currentCardView.image = self.backCardImage
            })
        }
        else {
            self.isShown = true;
            
            UIView.transition(with: self, duration: 1, options: UIView.AnimationOptions.transitionFlipFromLeft, animations: {
                self.currentCardView.image = self.cardImage
            })
        }
    }
}
