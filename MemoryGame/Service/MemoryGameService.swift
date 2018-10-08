//
//  MemoryGameService.swift
//  MemoryGame
//
//  Created by Gary O'Donoghue on 07/10/2018.
//  Copyright © 2018 Gary O'Donoghue. All rights reserved.
//

import UIKit
import CoreData


/// Service class used to interact provide means of saving user score 
class MemoryGameService {
    
    private var appDelegate : AppDelegate?
    private var context : NSManagedObjectContext?
    
    init(){
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate!.persistentContainer.viewContext
    }
    
    /// Save the user score to Core Data, to be retrieved and displayed in the list of high score
    ///
    /// - Parameters:
    ///   - username: the name entered by the user on saving of their score
    ///   - userScore: the score the user got in the game
    func saveUserScore(username: String, userScore: Int){
        let entity = NSEntityDescription.entity(forEntityName: "UserScore", in: context!)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue(username, forKey: "username")
        newUser.setValue(userScore, forKey: "score")
    }
}
