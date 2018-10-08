//
//  SaveScoreViewController.swift
//  MemoryGame
//
//  Created by Gary O'Donoghue on 08/10/2018.
//  Copyright © 2018 Gary O'Donoghue. All rights reserved.
//

import UIKit


/// View controller used for displaying user's score and allowing them to save this
/// value along with their username
class SaveScoreViewController: UIViewController {

    @IBOutlet weak var username : UITextField!
    @IBOutlet weak var saveBtn : UIButton!
    @IBOutlet weak var addUsernameMessage : UILabel!
    
    public var memoryGameViewModel: MemoryGameViewModel?
    
    /// Save button was clicked, check if the user entered a username and if so, save their score
    @IBAction func saveBtnClicked(){
        if(username.text?.isEmpty)!{
            self.addUsernameMessage.isHidden = false;
        }
        else {
            self.memoryGameViewModel!.saveUserScore(username: self.username.text!)
        }
    }
}
