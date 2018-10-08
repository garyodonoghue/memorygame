//
//  DifficultyViewController.swift
//  MemoryGame
//
//  Created by Gary O'Donoghue on 08/10/2018.
//  Copyright © 2018 Gary O'Donoghue. All rights reserved.
//

import UIKit


/// View controller used to allow the user to select the difficulty of the game
/// The higher difficulty means a higher number of cards presented to the user
class DifficultyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation

    
    /// Used to set the 'difficulty' value on the GameViewController depending on the user's ≈
    /// cardImage. This will determine the number of cards presented to the user.
    ///
    /// - Parameters:
    ///   - segue: the segue used to transition to the next view
    ///   - sender: the sender object 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "Low"){
            let easyGameViewController = segue.destination as? GameViewController
            easyGameViewController?.difficulty = 6
        }
        else if(segue.identifier == "Medium"){
            let easyGameViewController = segue.destination as? GameViewController
            easyGameViewController?.difficulty = 12
        }
        else if(segue.identifier == "Hard"){
            let easyGameViewController = segue.destination as? GameViewController
            easyGameViewController?.difficulty = 18
        }
    }
}
