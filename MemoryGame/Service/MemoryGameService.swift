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
    /// - Returns: whether the score was saved to CoreData successfully or not
    func saveUserScore(username: String, userScore: Int) -> Bool {
        var scoreSavedSuccessfully = true
        
        let entity = NSEntityDescription.entity(forEntityName: "UserScore", in: context!)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue(username, forKey: "username")
        newUser.setValue(userScore, forKey: "score")
        
        do {
            try self.context!.save()
        } catch {
            scoreSavedSuccessfully = false
        }
        
        return scoreSavedSuccessfully
    }
    
    /// Retrieve a list of user scores
    ///
    /// - Returns: array of Score objects containing username and score values
    func retrieveUserScores() -> [Score]{
        var userScores : [Score] = []
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserScore")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context!.fetch(request)
            for data in result as! [NSManagedObject] {
                let score = Score(username: data.value(forKey: "username") as! String, score: data.value(forKey: "score") as! Int)
                userScores.append(score)
            }
        } catch {
            print("Failed to retrieve user scores")
        }
        
        return userScores
    }
}
