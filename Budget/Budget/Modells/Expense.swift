//
//  Expense.swift
//  Budget
//
//  Created by Marvin Besken on 23.09.24.
//

import SwiftData
import Foundation

@Model
class Expense: Identifiable {
    var id: UUID = UUID()
    var amount: Double
    var adescription: String
    var date: Date
    var budget: Budget?

    init(amount: Double, description: String, date: Date = Date()) {
        self.id = UUID()
        self.amount = amount
        self.adescription = description
        self.date = date
    }
}


