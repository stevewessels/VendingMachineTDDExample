//
//  VendingMachine.swift
//  VendingMachine
//
//  Created by Stephan B Wessels on 3/5/17.
//  Copyright © 2017 Plum Street Systems. All rights reserved.
//

import Foundation

class VendingMachine {
    var returnTray: [Coin] = []
    var display = "INSERT COIN"
    let coinDetector = CoinDetector()
    var runningTotal: Int = 0
    
    func dropInCoin(diameter: Double, weight: Double) {
        let coin = coinDetector.processCoinWith(diameter: diameter, weight: weight)
        if !coinDetector.isValid(coin: coin) {
            returnTray.append(coin)
        } else {
            runningTotal += coin.value!
            display = "0.05"
        }
    }
}
