//
//  Budget.swift
//  Budget
//
//  Created by Marvin Besken on 23.09.24.
//

import SwiftData
import Foundation

@Model
class Budget: Identifiable {
    var id: UUID = UUID()
    var name: String
    var plannedAmount: Double
    var expenses: [Expense] = []
    var color: String
    var icon: String
    var expenses: [Expense] = []

    init(name: String, plannedAmount: Double, color: String = "blue", icon: String = "list.bullet") {
        self.id = UUID()
        self.name = name
        self.plannedAmount = plannedAmount
        self.color = color
        self.icon = icon
    }

    var totalSpent: Double {
        return expenses.reduce(0) { $0 + $1.amount }
    }

    var remainingBudget: Double {
        return plannedAmount - totalSpent
    }
}



