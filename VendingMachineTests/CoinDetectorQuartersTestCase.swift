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
        let detector = CoinDetector(diameter: 24.26, weight: 5.67)
        let coin = detector.coin()
        XCTAssertEqual(coin.name, "Quarter")
    }

    func testDetermineQuartersAreValidCoins() {
        let coin = Coin()
        let detector = CoinDetector(diameter: 1, weight: 1)
        coin.name = "Quarter"
        XCTAssertTrue(detector.isValid(coin: coin))
    }
    
}
