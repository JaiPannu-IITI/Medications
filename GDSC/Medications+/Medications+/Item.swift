//
//  Item.swift
//  Medications+
//
//  Created by Jai Pannu on 05/02/24.
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
