//
//  BudgetDeailView.swift
//  Budget
//
//  Created by Marvin Besken on 23.09.24.
//

import SwiftUI
import SwiftData

struct BudgetDetailView: View {
    var budget: Budget
    @Environment(\.modelContext) private var modelContext
    @State private var showAddExpense = false

    var body: some View {
        VStack {
            List {
                ForEach(budget.expenses) { expense in
                    VStack(alignment: .leading, spacing: 5) {
                        Text(expense.adescription)
                            .font(.headline)
                        Text("\(expense.amount, specifier: "%.2f") €")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        modelContext.delete(budget.expenses[index])
                    }
                }
            }
            .navigationBarTitle(budget.name, displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                showAddExpense.toggle()
            }, label: {
                Image(systemName: "plus")
                    .foregroundColor(.white)
            }))
            .sheet(isPresented: $showAddExpense) {
                AddExpenseView(budget: budget)
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.7)]),
                           startPoint: .top, endPoint: .bottom)
        )
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    let testExpenses = [
        Expense(adescription: "Dinner", amount: 20.0),
        Expense(adescription: "Groceries", amount: 50.0)
    ]
    
    BudgetDetailView(budget: Budget(name: "Beispiel", plannedAmount: 200.0, expenses: testExpenses))
}

