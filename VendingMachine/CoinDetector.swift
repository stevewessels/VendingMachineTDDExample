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
        }
    }
    
    func coin() -> Coin {
        let coin = Coin()
        coin.name = self.name
        return coin
    }
    
}
