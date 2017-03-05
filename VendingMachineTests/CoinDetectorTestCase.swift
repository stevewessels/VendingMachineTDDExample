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
        let detector = CoinDetector(diameter: 1, weight: 1)
        let coin = detector.coin()
        XCTAssertTrue(type(of: coin) == Coin.self)
    }
    
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
    
    func testCoinOfSmallSizeIsUnknown() {
        let detector = CoinDetector(diameter: 1.0, weight: 3)
        let coin = detector.coin()
        XCTAssertEqual(coin.name, "Unknown")
    }
    
    func testCoinOfPennySizeWithIncorrectWeightIsUnknown() {
        let detector = CoinDetector(diameter: 19.05, weight: 1.0)
        let coin = detector.coin()
        XCTAssertEqual(coin.name, "Unknown")
    }

}
