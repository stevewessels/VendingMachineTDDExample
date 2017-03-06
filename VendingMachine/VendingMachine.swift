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
    var dispenser: [Item] = []
    var inventory: [Int:[Item]] = [:]
    
    func dropInCoin(diameter: Double, weight: Double) {
        let coin = coinDetector.processCoinWith(diameter: diameter, weight: weight)
        if !coinDetector.isValid(coin: coin) {
            returnTray.append(coin)
        } else {
            runningTotal += coin.value!
            display = runningTotalAsDisplayString()
        }
    }
    
    private func runningTotalAsDisplayString() -> String {
        return String(format: "%.2f", Double(runningTotal) / 100.0)
    }
    
    func add(slot: Int, item: Item, qty: Int) {
        inventory[slot] = [Item]()
        for _ in 1...qty {
            inventory[slot]?.append(item)
        }
    }
    
    func selectFrom(column: Int) {
        if (inventory[column]?.count)! > 0 {
            let price = inventory[column]?[0].price
            if price! <= runningTotal {
                let item = inventory[column]?.removeFirst()
                dispense(item: item!)
            } else {
                // not enough cash to purchase
            }
        } else {
            // none left to buy
        }
    }
    
    private func dispense(item: Item) {
        dispenser.append(item)
        runningTotal -= item.price
        display = "THANK YOU"
    }
    
}
