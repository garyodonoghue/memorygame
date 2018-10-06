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
    
    // TODO When this is initialized, get one of the images retrieved from the service call and set this
    // property
    var cardImage = UIImage(named: "cat");
    
    var isShown: Bool = false
    
    
    
}
