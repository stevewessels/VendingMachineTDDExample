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
    
    init(diameter: Double, weight: Double) {
        self.diameter = diameter
        self.weight = weight
    }
    
    func name() -> String {
        if diameter == 19.05 {
            if weight >= 2.5 && weight <= 3.11 {
                return "Penny"
            }
        }
        return "Unknown coin"
    }
}
