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
    
    func testTheMachineWakesUpWithNoCoinsInTheReturnTray() {
        let machine = VendingMachine()
        XCTAssertTrue(machine.returnTray.isEmpty)
    }
    
    func testMachineWakesUpWithInsertCoinOnDisplay() {
        let machine = VendingMachine()
        XCTAssertEqual(machine.display, "INSERT COIN")
    }
    
    func testMachineWakesUpWithNothingInTheDispenser() {
        let machine = VendingMachine()
        XCTAssertTrue(machine.dispenser.isEmpty)
    }
    
    func testDroppingPennyIntoMachineEndsUpInReturnTray() {
        let machine = VendingMachine()
        machine.dropInCoin(diameter: 19.05, weight: 2.5)
        XCTAssertEqual(machine.display, "INSERT COIN")
        let contents = machine.returnTray
        XCTAssertEqual(contents.count, 1)
        let coin = contents.first
        XCTAssertEqual(coin?.name, "Penny")
        XCTAssertTrue(machine.dispenser.isEmpty)
    }
    
    func testDroppingNickelIntoMachineUpdatesDisplay() {
        let machine = VendingMachine()
        machine.dropInCoin(diameter: 21.21, weight: 5.0)
        XCTAssertEqual(machine.display, "0.05")
        XCTAssertTrue(machine.returnTray.isEmpty)
        XCTAssertTrue(machine.dispenser.isEmpty)
    }
    
    func testDropNickelAndAPennyIntoMachineUpdatesDisplayAndReturnTray() {
        let machine = VendingMachine()
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
        let machine = VendingMachine()
        machine.dropInCoin(diameter: 21.21, weight: 5.0)
        machine.dropInCoin(diameter: 21.21, weight: 5.0)
        XCTAssertEqual(machine.display, "0.10")
        XCTAssertTrue(machine.returnTray.isEmpty)
        XCTAssertTrue(machine.dispenser.isEmpty)
    }
    
    func testDropMultipleCoinsOfEachKindAndCheckDisplayAndReturnTray() {
        let machine = VendingMachine()
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
        let machine = VendingMachine()
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
        let machine = VendingMachine()
        machine.preload()
        XCTAssertEqual(machine.inventory[1]?.count, 12)
        XCTAssertEqual(machine.inventory[1]?[0].name, "cola")
        XCTAssertEqual(machine.inventory[2]?.count, 8)
        XCTAssertEqual(machine.inventory[2]?[0].name, "chips")
        XCTAssertEqual(machine.inventory[3]?.count, 6)
        XCTAssertEqual(machine.inventory[3]?[0].name, "candy")
    }
    
    func testPurchaseAColaExactChange() {
        let machine = VendingMachine()
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
    }
    
}

extension VendingMachine {
    func preload() {
        self.add(slot: 1, item: Item(name: "cola", price: 100), qty: 12)
        self.add(slot: 2, item: Item(name: "chips", price: 50), qty: 8)
        self.add(slot: 3, item: Item(name: "candy", price: 65), qty: 6)
    }
}
