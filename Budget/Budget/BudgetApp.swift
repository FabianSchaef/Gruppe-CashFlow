//
//  BudgetApp.swift
//  Budget
//
//  Created by Marvin Besken on 23.09.24.
//

import SwiftUI
import SwiftData

@main
struct BudgetApp: App {
    var body: some Scene {
        WindowGroup {
            BudgetListView()
                .modelContainer(for: [Budget.self, Expense.self])
        }
    }
}


