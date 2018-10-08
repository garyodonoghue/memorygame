//
//  Score.swift
//  MemoryGame
//
//  Created by Gary O'Donoghue on 08/10/2018.
//  Copyright © 2018 Gary O'Donoghue. All rights reserved.
//

import UIKit

class Score {

    var username : String?
    var score: Int?
    
    init(username : String, score: Int) {
        self.username = username
        self.score = score
    }
}

