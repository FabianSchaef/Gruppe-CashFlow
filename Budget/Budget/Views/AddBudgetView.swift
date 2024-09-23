//
//  AddBudgetView.swift
//  Budget
//
//  Created by Marvin Besken on 23.09.24.
//

import SwiftUI
import SwiftData

struct AddBudgetView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var name = ""
    @State private var plannedAmount = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Name des Budgets", text: $name)
                TextField("Geplantes Budget", text: $plannedAmount)
                    .keyboardType(.decimalPad)
            }
            .navigationBarTitle("Neues Budget", displayMode: .inline)
            .navigationBarItems(trailing: Button("Speichern") {
                if let amount = Double(plannedAmount), !name.isEmpty {
                    let newBudget = Budget(name: name, plannedAmount: amount)
                    modelContext.insert(newBudget)
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
    AddBudgetView()
}
