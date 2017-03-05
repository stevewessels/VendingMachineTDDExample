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
    
    func testsCoinOfPennySizeAndMinimumWeightIsIdentifiedAsPenny() {
        // The diameer of a penny is 19.05mm and can weigh between 2.5gm and 3.11gm
        let coin = CoinDetector(diameter: 19.05, weight: 2.5)
        XCTAssertEqual(coin.name, "Penny")
    }
    
    func testCoinOfSmallSizeIsUnknown() {
        let coin = CoinDetector(diameter: 1.0, weight: 3)
        XCTAssertEqual(coin.name, "Unknown Coin")
    }
    
    func testCoinOfPennySizeWithIncorrectWeightIsUnknown() {
        let coin = CoinDetector(diameter: 20, weight: 1.0)
        XCTAssertEqual(coin.name, "Unknown Coin")
    }

}
