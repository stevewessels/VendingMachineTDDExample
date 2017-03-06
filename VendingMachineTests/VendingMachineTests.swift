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
    
}
