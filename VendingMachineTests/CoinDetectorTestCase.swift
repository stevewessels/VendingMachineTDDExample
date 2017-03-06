//
//  CoinDetectorTestCase.swift
//  VendingMachine
//
//  Created by Stephan B Wessels on 3/5/17.
//  Copyright © 2017 Plum Street Systems. All rights reserved.
//

import XCTest
@testable import VendingMachine

class CoinDetectorTestCase: XCTestCase {
    
    func testCoinDetectorAnswerACoinObject() {
        let detector = CoinDetector()
        let coin = detector.processCoinWith(diameter: 1.0, weight: 3)
        XCTAssertTrue(type(of: coin) == Coin.self)
    }
    
    func testCoinOfSmallSizeIsUnknown() {
        let detector = CoinDetector()
        let coin = detector.processCoinWith(diameter: 1.0, weight: 3)
        XCTAssertEqual(coin.name, "Unknown")
    }
    
    func testCoinWithIncorrectWeightIsUnknown() {
        let detector = CoinDetector()
        let coin = detector.processCoinWith(diameter: 19.05, weight: 1.0)
        XCTAssertEqual(coin.name, "Unknown")
    }

    func testDetermineUnknownCoinsAreInValidCoins() {
        let coin = Coin()
        let detector = CoinDetector()
        coin.name = "Unknown"
        XCTAssertFalse(detector.isValid(coin: coin))
        coin.name = "Half Dollar"
        XCTAssertFalse(detector.isValid(coin: coin))
    }
    
    func testValueOfUnknownCoint() {
        let detector = CoinDetector()
        let coin = detector.processCoinWith(diameter: 1, weight: 1)
        XCTAssertEqual(coin.value, 0)
    }


}
