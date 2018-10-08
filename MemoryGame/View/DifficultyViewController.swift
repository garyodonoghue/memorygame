//
//  DifficultyViewController.swift
//  MemoryGame
//
//  Created by Gary O'Donoghue on 08/10/2018.
//  Copyright © 2018 Gary O'Donoghue. All rights reserved.
//

import UIKit

class DifficultyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation

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
