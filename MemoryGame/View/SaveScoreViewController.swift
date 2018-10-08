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
    @IBOutlet weak var userScore : UILabel!
    
    public var userScoreValue : Int = 0
    public var memoryGameViewModel: MemoryGameViewModel?
    
    override func viewDidLoad() {
        self.userScore.text = String(self.userScoreValue)
    }
    
    /// Save button was clicked, check if the user entered a username and if so, save their score
    @IBAction func saveBtnClicked(){
        if(username.text?.isEmpty)!{
            self.addUsernameMessage.isHidden = false;
        }
        else {
            self.memoryGameViewModel?.saveUserScore(username: self.username.text!)
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: Notification.Name("ReturnToMainMenu"), object: nil)
        }
    }
}
