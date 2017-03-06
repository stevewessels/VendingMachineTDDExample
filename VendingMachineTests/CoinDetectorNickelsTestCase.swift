//
//  CoinDetectorNickelsTestCase.swift
//  VendingMachine
//
//  Created by Stephan B Wessels on 3/5/17.
//  Copyright © 2017 Plum Street Systems. All rights reserved.
//

import XCTest
@testable import VendingMachine

class CoinDetectorNickelsTestCase: XCTestCase {
    
    func testCoinOfNickelSizeAndWeightIsIdentifiedAsNickel() {
        // The diameer of a nickel is 21.21mm and should weigh 5.0gm
        let detector = CoinDetector()
        let coin = detector.processCoinWith(diameter: 21.21, weight: 5.0)
        XCTAssertEqual(coin.name, "Nickel")
    }
    
    func testDetermineNickelsAreValidCoins() {
        let coin = Coin()
        let detector = CoinDetector()
        coin.name = "Nickel"
        XCTAssertTrue(detector.isValid(coin: coin))
    }
    
    func testValueOfProperNickel() {
        let detector = CoinDetector()
        let coin = detector.processCoinWith(diameter: 21.21, weight: 5.0)
        XCTAssertEqual(coin.value, 5)
    }
    
}
