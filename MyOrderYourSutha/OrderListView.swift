//
//  OrderListView.swift
//  MyOrderYourSutha
//
//  991703674
//  Created by Suthakaran Siva on 2024-10-10.
//

import SwiftUI

struct OrderListView: View {
    @ObservedObject var viewModel: OrderViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.pizzaOrders) { pizzaOrder in
                    OrderRowView(order: pizzaOrder, viewModel: viewModel)
                }
                .onDelete(perform: deleteOrder)
            }
            .navigationTitle("Orders")
            .onAppear {
                viewModel.fetchPizzaOrder()
            }
        }
    }

    private func deleteOrder(at offsets: IndexSet) {
        viewModel.deletePizzaOrder(indexSet: offsets)
    }
}

struct OrderRowView: View {
    @ObservedObject var order: PizzaOrder
    var viewModel: OrderViewModel

    var body: some View {
        NavigationLink(destination: EditOrderView(order: order, viewModel: viewModel)) {
            VStack(alignment: .leading) {
                Text("Pizza Type: \(order.pizza_type ?? "")")
                Text("Size: \(order.size ?? "")")
                Text("Quantity: \(order.quantity)")
                Text("Crust: \(order.crust_type ?? "")")
                if let date = order.date {
                    Text("Date: \(date, formatter: itemFormatter)")
                }
            }
        }
    }
}

struct EditOrderView: View {
    @ObservedObject var order: PizzaOrder
    var viewModel: OrderViewModel
    @State private var editedPizzaType: String = ""
    @State private var editedSize: String = ""
    @State private var editedQuantity: Double = .zero
    @State private var editedCrustType: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    
    let pizzaSizes = ["Small", "Medium", "Large"]
    let pizzaToppings = ["Cheese", "Pepperoni", "Veggie", "Meat Lovers", "Hawaiian"]
    let crustTypes = ["Thin", "Regular", "Thick"]

    var body: some View {
        Form {
            Picker("Toppings", selection: $editedPizzaType) {
                ForEach(pizzaToppings, id: \.self) { item in
                    Text(item)
                }
            }
            
            Picker("Pick a Size", selection: $editedSize) {
                ForEach(pizzaSizes, id: \.self) { item in
                    Text(item)
                }
            }
            

            Picker("Crust Type", selection: $editedCrustType) {
                ForEach(crustTypes, id: \.self) { item in
                    Text(item)
                }
            }
            
            Text("Amount of Pizza: \(Int(editedQuantity))")
            Slider(value: $editedQuantity, in: 0...10) {
                Text("Slider")
            } minimumValueLabel: {
                Text("0").font(.title2).fontWeight(.thin)
            } maximumValueLabel: {
                Text("10").font(.title2).fontWeight(.thin)
            }
            .tint(.red)
            .padding()
            
            Button("Save Changes") {
                viewModel.updatePizzaOrder(
                    id: order.id ?? UUID(),
                    newpizza_type: editedPizzaType,
                    newSize: editedSize,
                    newQuantity: String(Int(editedQuantity)),
                    newDate: order.date ?? Date(),
                    newcrust_type: editedCrustType
                )
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationTitle("Edit Order")
        .onAppear {
            editedPizzaType = order.pizza_type ?? ""
            editedSize = order.size ?? ""
            editedQuantity = Double(order.quantity)
            editedCrustType = order.crust_type ?? ""
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    OrderListView(viewModel: OrderViewModel())
}
