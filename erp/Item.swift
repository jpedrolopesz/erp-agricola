//
//  Item.swift
//  erp
//
//  Created by Joao Pedro Lopes Zamonelo on 15/04/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
