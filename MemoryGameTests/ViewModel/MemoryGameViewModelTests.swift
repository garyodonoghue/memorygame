//
//  MemoryGameViewModelTests.swift
//  MemoryGameTests
//
//  Created by Gary O'Donoghue on 08/10/2018.
//  Copyright © 2018 Gary O'Donoghue. All rights reserved.
//

import UIKit
import XCTest

/// Test class used to test the logic within MemoryGameViewModel
class MemoryGameViewModelTests: XCTestCase {

    var classUnderTest : MemoryGameViewModel?
    
    override func setUp() {
        classUnderTest = MemoryGameViewModel()
    }

    func testHandleCardSelectionWhenCardIsShown() {
        // Arrange.
        let card = MemoryGameCard()
        classUnderTest?.allImagesLoaded = true
        
        // Act.
        let response = classUnderTest!.handleCardSelection(selectedCard: card, difficulty: 16)
        
        // Assert.
        XCTAssertFalse(response)
    }
    
    func testHandleCardSelectionWhenAllImagesHaveNotYetLoaded() {
        // Arrange.
        let card = MemoryGameCard()
        card.isShown = true
        classUnderTest?.allImagesLoaded = false
        
        // Act.
        let response = classUnderTest!.handleCardSelection(selectedCard: card, difficulty: 16)
        
        // Assert.
        XCTAssertFalse(response)
    }
    
    func testUserFlipsFirstCard() {
        // Arrange.
        let card = MemoryGameCard()
        card.isShown = true
        classUnderTest?.allImagesLoaded = true
        
        // Act.
        let response = classUnderTest!.handleCardSelection(selectedCard: card, difficulty: 16)
        
        // Assert.
        XCTAssertFalse(response)
    }
    
    func testUserMatchesFirstPair() {
        // Arrange.
        classUnderTest?.allImagesLoaded = true
        let cardImage = UIImage()
        
        let card1 = MemoryGameCard()
        card1.isShown = false
        card1.cardImage = cardImage
        
        let card2 = MemoryGameCard()
        card2.isShown = false
        card2.cardImage = cardImage
        
        // Act.
        let response1 = classUnderTest!.handleCardSelection(selectedCard: card1, difficulty: 16)
        let response2 = classUnderTest!.handleCardSelection(selectedCard: card2, difficulty: 16)
        
        // Assert.
        XCTAssertFalse(response1)
        XCTAssertFalse(response2)
        XCTAssertEqual(classUnderTest?.userScore, 1)
    }
    
    func testUserMatchesAllCardsAndFinishesGame() {
        // Arrange.
        classUnderTest?.allImagesLoaded = true
        let cardImage = UIImage()
        
        let card1 = MemoryGameCard()
        card1.isShown = false
        card1.cardImage = cardImage
        
        let card2 = MemoryGameCard()
        card2.isShown = false
        card2.cardImage = cardImage
        
        // Act.
        let response1 = classUnderTest!.handleCardSelection(selectedCard: card1, difficulty: 2)
        let response2 = classUnderTest!.handleCardSelection(selectedCard: card2, difficulty: 2)
        
        // Assert.
        XCTAssertFalse(response1)
        XCTAssertTrue(response2)
        XCTAssertEqual(classUnderTest?.userScore, 6)
    }
    
    func testDecrementTimer(){
        // Arrange.
        
        // Act.
        let response = classUnderTest?.decrementTimer()
        
        // Assert.
        XCTAssertEqual(response, "59s")
    }
    
    func testDecrementTimerTimeUp(){
        // Arrange.
        classUnderTest?.remainingTime = 1
        
        // Act.
        let response = classUnderTest?.decrementTimer()
        
        // Assert.
        XCTAssertEqual(response, "0s")
        XCTAssertTrue((classUnderTest?.gameOver)!)
    }
}
