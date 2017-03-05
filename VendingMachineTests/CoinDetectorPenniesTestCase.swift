//
//  CoinDetectorPenniesTestCase.swift
//  VendingMachine
//
//  Created by Stephan B Wessels on 3/5/17.
//  Copyright © 2017 Plum Street Systems. All rights reserved.
//

import XCTest
@testable import VendingMachine

class CoinDetectorPenniesTestCase: XCTestCase {
    
    func testCoinOfPennySizeAndMinimumWeightIsIdentifiedAsPenny() {
        // The diameer of a penny is 19.05mm and can weigh between 2.5gm and 3.11gm
        let detector = CoinDetector(diameter: 19.05, weight: 2.5)
        let coin = detector.coin()
        XCTAssertEqual(coin.name, "Penny")
    }
    
    func testCoinOfPennySizeAndMaximumWeightIsIdentifiedAsPenny() {
        let detector = CoinDetector(diameter: 19.05, weight: 3.11)
        let coin = detector.coin()
        XCTAssertEqual(coin.name, "Penny")
    }
    
    func testCoinOfPennySizeAndInBetweenValidWeightIsIdentifiedAsPenny() {
        let detector = CoinDetector(diameter: 19.05, weight: 3.0)
        let coin = detector.coin()
        XCTAssertEqual(coin.name, "Penny")
    }
    
    func testDeterminePenniesAreInValidCoins() {
        let coin = Coin()
        let detector = CoinDetector(diameter: 1, weight: 1)
        coin.name = "Penny"
        XCTAssertFalse(detector.isValid(coin: coin))
    }

    
}
