//
//  CoinDetector.swift
//  VendingMachine
//
//  Created by Stephan B Wessels on 3/5/17.
//  Copyright © 2017 Plum Street Systems. All rights reserved.
//

import Foundation

class CoinDetector {
    var diameter: Double?
    var weight: Double?
    var name: String = "Unknown"
    
    func processCoinWith(diameter: Double, weight: Double) -> Coin {
        self.diameter = diameter
        self.weight = weight
        if diameter == 19.05 {
            if weight >= 2.5 && weight <= 3.11 {
                self.name = "Penny"
            }
        } else if diameter == 21.21 {
            if weight == 5.0 {
                self.name = "Nickel"
            }
        } else if diameter == 17.91 {
            if weight == 2.27 {
                self.name = "Dime"
            }
        } else if diameter == 24.26 {
            if weight == 5.67 {
                self.name = "Quarter"
            }
        }
        return self.coin()
    }
    
    private func coin() -> Coin {
        let coin = Coin()
        coin.name = self.name
        switch coin.name! {
        case "Penny": coin.value = 1
        case "Nickel": coin.value = 5
        case "Dime": coin.value = 10
        case "Quarter": coin.value = 25
        default: coin.value = 0
        }
        return coin
    }
    
    func isValid(coin: Coin) -> Bool {
        switch coin.name! {
        case "Nickel": return true
        case "Dime": return  true
        case "Quarter": return true
        default: return false
        }
    }
    
}
