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
    var display = ""
    let coinDetector = CoinDetector()
    var runningTotal: Int = 0
    var dispenser: [Item] = []
    var inventory: [Int:[Item]] = [:]
    var transactionCoins: [Coin]?
    var availableCoinsForChange: [Coin] = []
    
    init() {
        transactionCoins = []
        let nickel = Coin()
        nickel.name = "Nickel"
        nickel.value = 5
        availableCoinsForChange.append(nickel)
        setDisplayReady()
    }
    
    func dropInCoin(diameter: Double, weight: Double) {
        let coin = coinDetector.processCoinWith(diameter: diameter, weight: weight)
        if !coinDetector.isValid(coin: coin) {
            returnTray.append(coin)
        } else {
            runningTotal += coin.value!
            transactionCoins?.append(coin)
            display = runningTotalAsDisplayString()
        }
    }
    
    private func runningTotalAsDisplayString() -> String {
        return String(format: "%.2f", Double(runningTotal) / 100.0)
    }
    
    func add(slot: Int, item: Item, qty: Int) {
        inventory[slot] = [Item]()
        if qty < 1 { return }
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
                self.display = String(format: "PRICE %.2f", Double(price!) / 100.0)
                insertCoinDisplayDelayed()
            }
        } else {
            // none left to buy
            self.display = "SOLD OUT"
            if runningTotal > 0 {
                runningBalanceDisplayedDelayed()
            } else {
                insertCoinDisplayDelayed()
            }
        }
    }
    
    func returnButtonPressed() {
        returnTray = transactionCoins!
        insertCoinDisplayDelayed()
    }
    
    func removeCoinsFromChange() {
        availableCoinsForChange.removeAll()
        setDisplayReady()
    }
    
    private func dispense(item: Item) {
        dispenser.append(item)
        runningTotal -= item.price
        if runningTotal > 0 {
            // Simplest solution for now is to hard code a nickel
            let change = Coin()
            change.name = "Nickel"
            change.value = 5
            returnTray.append(change)
        }
        display = "THANK YOU"
        insertCoinDisplayDelayed()
    }
    
    private func insertCoinDisplayDelayed() {
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.setDisplayReady()
        }
    }
    
    private func setDisplayReady() {
        if !self.availableCoinsForChange.isEmpty {
            self.display = "INSERT COIN"
        } else {
            self.display = "EXACT CHANGE ONLY"
        }
    }
    
    private func runningBalanceDisplayedDelayed() {
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.display = self.runningTotalAsDisplayString()
        }
    }
    
}
