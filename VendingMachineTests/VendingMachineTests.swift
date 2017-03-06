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
    
    func testDroppingPennyIntoMachineEndsUpInReturnTray() {
        let machine = VendingMachine()
        machine.dropInCoin(diameter: 19.05, weight: 2.5)
        XCTAssertEqual(machine.display, "INSERT COIN")
        let contents = machine.returnTray
        XCTAssertEqual(contents.count, 1)
        let coin = contents.first
        XCTAssertEqual(coin?.name, "Penny")
    }
    
}
