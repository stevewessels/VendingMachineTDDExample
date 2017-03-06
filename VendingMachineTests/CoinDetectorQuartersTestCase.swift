//
//  CoinDetectorQuartersTestCase.swift
//  VendingMachine
//
//  Created by Stephan B Wessels on 3/5/17.
//  Copyright © 2017 Plum Street Systems. All rights reserved.
//

import XCTest
@testable import VendingMachine

class CoinDetectorQuartersTestCase: XCTestCase {
    
    func testCoinOfQuarterSizeAndWeightIsIdentifiedAsQuarter() {
        // The diameter of a quarter is 24.26mm and weighs 5.67gm
        let detector = CoinDetector()
        let coin = detector.processCoinWith(diameter: 24.26, weight: 5.67)
        XCTAssertEqual(coin.name, "Quarter")
    }

    func testDetermineQuartersAreValidCoins() {
        let coin = Coin()
        let detector = CoinDetector()
        coin.name = "Quarter"
        XCTAssertTrue(detector.isValid(coin: coin))
    }
    
    func testValueOfProperQuarter() {
        let detector = CoinDetector()
        let coin = detector.processCoinWith(diameter: 24.26, weight: 5.67)
        XCTAssertEqual(coin.value, 25)
    }
    
}
