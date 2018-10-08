//
//  HighScoresTableViewController.swift
//  MemoryGame
//
//  Created by Gary O'Donoghue on 08/10/2018.
//  Copyright © 2018 Gary O'Donoghue. All rights reserved.
//

import UIKit


/// View Controller used for displaying the high scores
class HighScoresTableViewController: UITableViewController {

    var memoryGameViewModel = MemoryGameViewModel()
    private var userScores : [Score]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userScores = memoryGameViewModel.retrieveUserScores()
        
        // sort the user scores highest to lowest
        userScores = userScores!.sorted { (score1 : Score, score2: Score) -> Bool in
            return score1.score! > score2.score!
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userScores!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserScore", for: indexPath)
        if(self.userScores!.count >= indexPath.row){
            let userScore = self.userScores![indexPath.row]
            cell.textLabel?.text = "\(userScore.username!) : \(userScore.score!) point(s)"
            cell.textLabel?.textAlignment = NSTextAlignment.center
        }
        
        return cell
    }
}
