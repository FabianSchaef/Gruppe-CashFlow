//
//  AddExpenseView.swift
//  Budget
//
//  Created by Marvin Besken on 23.09.24.
//

import SwiftUI
import SwiftData

struct AddExpenseView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var amount = ""
    @State private var description = ""
    var budget: Budget

    var body: some View {
        NavigationView {
            Form {
                TextField("Beschreibung", text: $description)
                TextField("Betrag", text: $amount)
                    .keyboardType(.decimalPad)
            }
            .navigationBarTitle("Neue Ausgabe", displayMode: .inline)
            .navigationBarItems(trailing: Button("Speichern") {
                if let amount = Double(amount) {
                    let newExpense = Expense(amount: amount, description: description)
                    budget.expenses.append(newExpense)
                    modelContext.insert(newExpense)
                    dismiss()
                }
            })
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                           startPoint: .top, endPoint: .bottom)
        )
    }
}

#Preview {
    AddExpenseView(budget: Budget(name: "Beispiel", plannedAmount: 100.0))
}


