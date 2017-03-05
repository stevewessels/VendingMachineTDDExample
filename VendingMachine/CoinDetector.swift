//
//  CoinDetector.swift
//  VendingMachine
//
//  Created by Stephan B Wessels on 3/5/17.
//  Copyright © 2017 Plum Street Systems. All rights reserved.
//

import Foundation

class CoinDetector {
    var diameter: Double
    var weight: Double
    var name: String = "Unknown"
    
    init(diameter: Double, weight: Double) {
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
    }
    
    func coin() -> Coin {
        let coin = Coin()
        coin.name = self.name
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
