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
    
    func testCoinOfSmallSizeIsUnknown() {
        let detector = CoinDetector(diameter: 1.0, weight: 3)
        let coin = detector.coin()
        XCTAssertEqual(coin.name, "Unknown")
    }
    
    func testCoinWithIncorrectWeightIsUnknown() {
        let detector = CoinDetector(diameter: 19.05, weight: 1.0)
        let coin = detector.coin()
        XCTAssertEqual(coin.name, "Unknown")
    }
    
}
