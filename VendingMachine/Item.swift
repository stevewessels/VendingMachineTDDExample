//
//  Item.swift
//  VendingMachine
//
//  Created by Stephan B Wessels on 3/5/17.
//  Copyright © 2017 Plum Street Systems. All rights reserved.
//

import Foundation

class Item {
    
    var name = ""
    var price = 0
    
    init(name: String, price: Int) {
        self.name = name
        self.price = price
    }
    
}
