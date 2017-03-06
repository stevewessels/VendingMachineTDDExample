//
//  VendingMachineTests.swift
//  VendingMachineTests
//
//  Created by Stephan B Wessels on 3/5/17.
//  Copyright © 2017 Plum Street Systems. All rights reserved.
//

import XCTest
@testable import VendingMachine

class VendingMachineTests: XCTestCase {
    
    var waitExpectation: XCTestExpectation?
    let machine = VendingMachine()

    func testTheMachineWakesUpWithNoCoinsInTheReturnTray() {
        XCTAssertTrue(machine.returnTray.isEmpty)
    }
    
    func testMachineWakesUpWithInsertCoinOnDisplay() {
        XCTAssertEqual(machine.display, "INSERT COIN")
    }
    
    func testMachineWakesUpWithNothingInTheDispenser() {
        XCTAssertTrue(machine.dispenser.isEmpty)
    }
    
    func testDroppingPennyIntoMachineEndsUpInReturnTray() {
        machine.dropInCoin(diameter: 19.05, weight: 2.5)
        XCTAssertEqual(machine.display, "INSERT COIN")
        let contents = machine.returnTray
        XCTAssertEqual(contents.count, 1)
        let coin = contents.first
        XCTAssertEqual(coin?.name, "Penny")
        XCTAssertTrue(machine.dispenser.isEmpty)
    }
    
    func testDroppingNickelIntoMachineUpdatesDisplay() {
        machine.dropInCoin(diameter: 21.21, weight: 5.0)
        XCTAssertEqual(machine.display, "0.05")
        XCTAssertTrue(machine.returnTray.isEmpty)
        XCTAssertTrue(machine.dispenser.isEmpty)
    }
    
    func testDropNickelAndAPennyIntoMachineUpdatesDisplayAndReturnTray() {
        machine.dropInCoin(diameter: 21.21, weight: 5.0)
        machine.dropInCoin(diameter: 19.05, weight: 2.5)
        XCTAssertEqual(machine.display, "0.05")
        let contents = machine.returnTray
        XCTAssertEqual(contents.count, 1)
        let coin = contents.first
        XCTAssertEqual(coin?.name, "Penny")
        XCTAssertTrue(machine.dispenser.isEmpty)
    }
    
    func testDropMultipleGoodCoinsIntoMachineAndCheckDisplayAndReturnTray() {
        machine.dropInCoin(diameter: 21.21, weight: 5.0)
        machine.dropInCoin(diameter: 21.21, weight: 5.0)
        XCTAssertEqual(machine.display, "0.10")
        XCTAssertTrue(machine.returnTray.isEmpty)
        XCTAssertTrue(machine.dispenser.isEmpty)
    }
    
    func testDropMultipleCoinsOfEachKindAndCheckDisplayAndReturnTray() {
        machine.dropInCoin(diameter: 21.21, weight: 5.0)
        machine.dropInCoin(diameter: 17.91, weight: 2.27)
        machine.dropInCoin(diameter: 24.26, weight: 5.67)
        machine.dropInCoin(diameter: 19.05, weight: 2.5)
        XCTAssertEqual(machine.display, "0.40")
        let contents = machine.returnTray
        XCTAssertEqual(contents.count, 1)
        let coin = contents.first
        XCTAssertEqual(coin?.name, "Penny")
        XCTAssertTrue(machine.dispenser.isEmpty)
    }
    
    func testAddInventoryOfItemsToMachineManually() {
        machine.add(slot: 1, item: Item(name: "cola", price: 100), qty: 12)
        machine.add(slot: 2, item: Item(name: "chips", price: 50), qty: 8)
        machine.add(slot: 3, item: Item(name: "candy", price: 65), qty: 6)
        XCTAssertEqual(machine.inventory[1]?.count, 12)
        XCTAssertEqual(machine.inventory[1]?[0].name, "cola")
        XCTAssertEqual(machine.inventory[2]?.count, 8)
        XCTAssertEqual(machine.inventory[2]?[0].name, "chips")
        XCTAssertEqual(machine.inventory[3]?.count, 6)
        XCTAssertEqual(machine.inventory[3]?[0].name, "candy")
    }
    
    func testPreloadedMachineContents() {
        machine.preload()
        XCTAssertEqual(machine.inventory[1]?.count, 12)
        XCTAssertEqual(machine.inventory[1]?[0].name, "cola")
        XCTAssertEqual(machine.inventory[2]?.count, 8)
        XCTAssertEqual(machine.inventory[2]?[0].name, "chips")
        XCTAssertEqual(machine.inventory[3]?.count, 6)
        XCTAssertEqual(machine.inventory[3]?[0].name, "candy")
    }
    
    func testPurchaseAColaExactChange() {
        machine.preload()
        machine.dropInCoin(diameter: 24.26, weight: 5.67)
        machine.dropInCoin(diameter: 24.26, weight: 5.67)
        machine.dropInCoin(diameter: 24.26, weight: 5.67)
        machine.dropInCoin(diameter: 24.26, weight: 5.67)
        machine.selectFrom(column: 1)
        XCTAssertEqual(machine.display, "THANK YOU")
        XCTAssertTrue(machine.returnTray.isEmpty)
        let item = machine.dispenser[0]
        XCTAssertEqual(item.name, "cola")
        waitForReset(duration: 4)
    }
    
    func testPurchaseWithNotEnoughChangeDisplaysCorrectlyAndDoesNotDispense() {
        machine.preload()
        machine.dropInCoin(diameter: 24.26, weight: 5.67)
        machine.dropInCoin(diameter: 24.26, weight: 5.67)
        machine.dropInCoin(diameter: 24.26, weight: 5.67)
        machine.selectFrom(column: 1)
        XCTAssertEqual(machine.display, "PRICE 1.00")
        XCTAssertTrue(machine.returnTray.isEmpty)
        XCTAssertTrue(machine.dispenser.isEmpty)
        waitForReset(duration: 4)
    }
    
    func testOverPayAndCheckDispensedWithChange() {
        machine.preload()
        machine.dropInCoin(diameter: 24.26, weight: 5.67)
        machine.dropInCoin(diameter: 24.26, weight: 5.67)
        machine.dropInCoin(diameter: 24.26, weight: 5.67)
        machine.dropInCoin(diameter: 17.91, weight: 2.27)
        machine.dropInCoin(diameter: 17.91, weight: 2.27)
        machine.dropInCoin(diameter: 17.91, weight: 2.27)
        machine.selectFrom(column: 1)
        XCTAssertEqual(machine.display, "THANK YOU")
        let returnedCoins = machine.returnTray
        XCTAssertEqual(returnedCoins.count, 1)
        let returnedCoin = returnedCoins.first
        XCTAssertEqual(returnedCoin?.name, "Nickel")
        let item = machine.dispenser[0]
        XCTAssertEqual(item.name, "cola")
        waitForReset(duration: 4)
    }
    
    func testCustomerPutsInCoinsThenAsksForMoneyBack() {
        machine.preload()
        machine.dropInCoin(diameter: 24.26, weight: 5.67)
        machine.returnButtonPressed()
        XCTAssertTrue(machine.returnTray.count == 1)
        XCTAssertTrue(machine.returnTray.first?.name == "Quarter")
        waitForReset(duration: 4)
    }
    
    func testCandyIsSoldOutAndWeNotifyCustomerAndThenShowRunningBalance() {
        machine.preloadWithNoCandy()
        // Put in 75 cents, more than enough for candy
        machine.dropInCoin(diameter: 24.26, weight: 5.67)
        machine.dropInCoin(diameter: 24.26, weight: 5.67)
        machine.dropInCoin(diameter: 24.26, weight: 5.67)
        machine.selectFrom(column: 3)   // There is none
        XCTAssertEqual(machine.display, "SOLD OUT")
        waitForRemainingBalance(duration: 4)
    }
    
    func testCandyIsSoldOutCustomerPutInNoCoinsYetChooseCandyAndWeDisplaySoldOutThenInsertCoins() {
        machine.preloadWithNoCandy()
        machine.selectFrom(column: 3)   // There is none
        XCTAssertEqual(machine.display, "SOLD OUT")
        waitForReset(duration: 4)

    }
    
    private func waitForRemainingBalance(duration: TimeInterval) {
        waitExpectation = expectation(description: "waitForReset")
        Timer.scheduledTimer(timeInterval: duration,
                             target: self,
                             selector: #selector(VendingMachineTests.onRemainingBalanceTimer),
                             userInfo: nil,
                             repeats: false)
        waitForExpectations(timeout: duration + 3, handler: nil)
    }
    
    private func waitForReset(duration: TimeInterval) {
        waitExpectation = expectation(description: "waitForReset")
        Timer.scheduledTimer(timeInterval: duration,
                             target: self,
                             selector: #selector(VendingMachineTests.onInsertCoinTimer),
                             userInfo: nil,
                             repeats: false)
        waitForExpectations(timeout: duration + 3, handler: nil)
    }
    
    func onInsertCoinTimer() {
        waitExpectation?.fulfill()
        XCTAssertEqual(machine.display, "INSERT COIN")
    }
    
    func onRemainingBalanceTimer() {
        waitExpectation?.fulfill()
        XCTAssertEqual(machine.display, "0.75")
    }
    
}

extension VendingMachine {
    func preload() {
        self.add(slot: 1, item: Item(name: "cola", price: 100), qty: 12)
        self.add(slot: 2, item: Item(name: "chips", price: 50), qty: 8)
        self.add(slot: 3, item: Item(name: "candy", price: 65), qty: 6)
    }
    
    func preloadWithNoCandy() {
        self.add(slot: 1, item: Item(name: "cola", price: 100), qty: 12)
        self.add(slot: 2, item: Item(name: "chips", price: 50), qty: 8)
        self.add(slot: 3, item: Item(name: "candy", price: 65), qty: 0)
    }

}
