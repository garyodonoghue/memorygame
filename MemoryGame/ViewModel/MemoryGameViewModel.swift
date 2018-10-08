//
//  MemoryGameViewModel.swift
//  MemoryGame
//
//  Created by Gary O'Donoghue on 07/10/2018.
//  Copyright © 2018 Gary O'Donoghue. All rights reserved.
//

import UIKit

class MemoryGameViewModel {

    var gameOver : Bool = false
    var userScore = 0
    
    private var flippedCards : [CardCollectionViewCell]  = []
    private var matchedCards : Int = 0
    private var remainingTime : Int = 10
    private var gameTimer : Timer

    init(gameTimer : Timer) {
        self.gameTimer = gameTimer
    }
    
    
    /// Handle the selectio of a card - if it is already flipped over, dont do anything
    /// otherwise, flip it over to reveal the image on the back of the card
    /// if this is the second 'go', i.e. the user has flipped two cards in this turn, check
    /// to see if the images on the backs of the card match, if they do, the user has scored a point
    /// and the cards will remain flipped over.
    ///
    /// If all cards have been flipped over, the game is over and the user's score should be saved
    ///
    /// - Parameters:
    ///   - selectedCell: the card the user selected
    ///   - difficulty: the number of cards on the screen
    /// - Returns: true if all cards have been flipped over, i.e. the user has matched all the cards
    func handleCardSelection(selectedCell: CardCollectionViewCell, difficulty: Int) -> Bool{
        
        // only care about the cards that aren't 'shown', i.e. face up
        if(!selectedCell.isShown){
            selectedCell.flipCard()
            flippedCards.append(selectedCell)
            
            if(flippedCards.count == 2){
                let card1 = flippedCards[0] as CardCollectionViewCell
                let card2 = flippedCards[1] as CardCollectionViewCell
                
                if(card1.cardImage == card2.cardImage){
                    card1.isMatched = true
                    card2.isMatched = true
                    self.matchedCards = self.matchedCards+2
                    self.userScore = self.userScore + 1;
                }
                else{
                    card1.flipCard()
                    card2.flipCard()
                }
                
                flippedCards.removeAll()
                
                // all the cards have been matched, stop the timer and save the score
                if(self.matchedCards == difficulty){
                    self.userScore = self.userScore + 5
                    self.gameTimer.invalidate()
                    gameOver = true
                }
            }
        }
        
        return gameOver
    }
    
    
    /// Update the remaining time the user has to complete the game
    ///
    /// - Returns: the new text value of the remaining time to be displayed to the user
    func updateTimer() -> String {
        self.remainingTime = self.remainingTime - 1
        let timerText = "\(String(self.remainingTime))s"
        
        /// if the timer reaches zero, the game is over and the user's score is saved
        if(self.remainingTime <= 0){
            self.gameTimer.invalidate()
            self.gameOver = true;
        }
        
        return timerText
    }
    
    /// Save the user's score along with their entered username
    func saveUserScore(username: String){
        // write user score to core data
        let memoryGameService = MemoryGameService()
        memoryGameService.saveUserScore(username: username, userScore: self.userScore)
    }
}
