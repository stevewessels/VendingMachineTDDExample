//
//  CoinDetectorDimesTestCase.swift
//  VendingMachine
//
//  Created by Stephan B Wessels on 3/5/17.
//  Copyright © 2017 Plum Street Systems. All rights reserved.
//

import XCTest
@testable import VendingMachine

class CoinDetectorDimesTestCase: XCTestCase {
    
    func testCoinOfDimeSizeAndWeightIsIdentifiedAsDime() {
        // The diameter of a dime is 17.91mm and weighs 2.268gm
        let detector = CoinDetector()
        let coin = detector.processCoinWith(diameter: 17.91, weight: 2.27)
        XCTAssertEqual(coin.name, "Dime")
    }
    
    func testDetermineDimesAreValidCoins() {
        let coin = Coin()
        let detector = CoinDetector()
        coin.name = "Dime"
        XCTAssertTrue(detector.isValid(coin: coin))
    }
    
    func testValueOfProperDime() {
        let detector = CoinDetector()
        let coin = detector.processCoinWith(diameter: 17.91, weight: 2.27)
        XCTAssertEqual(coin.value, 10)
    }

}
