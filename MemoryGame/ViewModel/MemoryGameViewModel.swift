//
//  MemoryGameViewModel.swift
//  MemoryGame
//
//  Created by Gary O'Donoghue on 07/10/2018.
//  Copyright © 2018 Gary O'Donoghue. All rights reserved.
//

import UIKit

class MemoryGameViewModel {

    private var flippedCards : [CardCollectionViewCell]  = []
    private var matchedCards : Int = 0;
    private var userScore = 0;
    private var remainingTime : Int = 60
    private var gameTimer : Timer;

    init(gameTimer : Timer) {
        self.gameTimer = gameTimer
    }
    
    func handleCardSelection(selectedCell: CardCollectionViewCell, difficulty: Int) -> Bool{
        var matchedAllCards : Bool = false
        
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
                    matchedAllCards = true
                }
            }
        }
        
        return matchedAllCards
    }
    
    func updateTimer() -> String {
        self.remainingTime = self.remainingTime - 1
        let timerText = "\(String(self.remainingTime))s"
        
        if(self.remainingTime <= 0){
            self.gameTimer.invalidate()
        }
        
        return timerText
    }
    
    func saveUserScore(){
        // write user score to core data
        let memoryGameService = MemoryGameService()
        memoryGameService.saveUserScore(userScore: self.userScore)
    }
}
