//
//  BudgetListView.swift
//  Budget
//
//  Created by Marvin Besken on 23.09.24.
//

import SwiftUI
import SwiftData

struct BudgetListView: View {
    @Query var budgets: [Budget]
    @Environment(\.modelContext) private var modelContext
    @State private var showAddBudget = false

    var totalBudget: Double {
        return budgets.reduce(0) { $0 + $1.plannedAmount }
    }
    
    

    var body: some View {
        NavigationView {
            VStack {
                if budgets.isEmpty {
                    Text("Keine Budgets vorhanden. Fügen Sie eines hinzu!")
                        .foregroundColor(.white)
                        .padding()
                } else {
                    List {
                        ForEach(budgets) { budget in
                            NavigationLink(destination: BudgetDetailView(budget: budget)) {
                                HStack {
                                    Image(systemName: budget.icon)
                                        .foregroundColor(Color(budget.color))
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(budget.name)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        ProgressView(value: budget.totalSpent, total: budget.plannedAmount)
                                            .progressViewStyle(LinearProgressViewStyle())
                                        Text("Verfügbar: \(budget.remainingBudget, specifier: "%.2f") €")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .padding()
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                modelContext.delete(budgets[index])
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }

                Text("Gesamtbudget: \(totalBudget, specifier: "%.2f") €")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
            }
            .navigationBarTitle("Budgets")
            .navigationBarItems(trailing: Button(action: {
                showAddBudget.toggle()
            }, label: {
                Image(systemName: "plus")
                    .foregroundColor(.white)
            }))
            .sheet(isPresented: $showAddBudget) {
                AddBudgetView()
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                               startPoint: .top, endPoint: .bottom)
            )
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    BudgetListView()
}



