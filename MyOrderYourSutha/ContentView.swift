//  991703674
//  SUthakaran Siva

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var viewModel: OrderViewModel
    
    @State private var selectedSize = "Select Size"
    @State private var selectedToppings = "Select Toppings"
    @State private var selectedCrust = "Select Crust"
    @State private var pizzaQuantity: Double = .zero

    let pizzaSizes = ["Select Size", "Small", "Medium", "Large"]
    let pizzaToppings = ["Select Toppings", "Cheese", "Pepperoni", "Veggie", "Meat Lovers", "Hawaiian"]
    let crustTypes = ["Select Crust", "Thin", "Regular", "Thick"]

    var body: some View {
        NavigationView {
            Form {
                Section("Make Your Order") {
                    Picker("Pick a Size", selection: $selectedSize) {
                        ForEach(pizzaSizes, id: \.self) { item in
                            Text(item)
                        }
                    }

                    Picker("Topping", selection: $selectedToppings) {
                        ForEach(pizzaToppings, id: \.self) { item in
                            Text(item)
                        }
                    }

                    Picker("Crust Type", selection: $selectedCrust) {
                        ForEach(crustTypes, id: \.self) { item in
                            Text(item)
                        }
                    }

                    Text("Amount of Pizza: \(Int(pizzaQuantity))")
                    Slider(value: $pizzaQuantity, in: 0...10) {
                        Text("Slider")
                    } minimumValueLabel: {
                        Text("0").font(.title2).fontWeight(.thin)
                    } maximumValueLabel: {
                        Text("10").font(.title2).fontWeight(.thin)
                    }
                    .tint(.red)
                    .padding()
                    
                    if !isValidSelection() {
                        Text("Please select a size, topping, crust type, and quantity")
                            .foregroundColor(.red)
                                }
                    
                }
                Button("Make Order") {
                    viewModel.addPizzaOrder(
                        pizza_type: selectedToppings,
                        size: selectedSize,
                        quantity: String(Int(pizzaQuantity)),
                        date: Date(),
                        crust_type: selectedCrust
                    )
                   
                    // Reset selections
                    selectedSize = "Select Size"
                    selectedToppings = "Select Toppings"
                    selectedCrust = "Select Crust"
                    pizzaQuantity = 0
                }
                .disabled(!isValidSelection())
            }
            .navigationTitle("Suthas Pizza Shop")
        }
        
    }
    func isValidSelection() -> Bool {
        return selectedSize != "Select Size" &&
               selectedToppings != "Select Toppings" &&
               selectedCrust != "Select Crust" &&
        pizzaQuantity > 0
    }
}

#Preview {
    ContentView(viewModel: OrderViewModel())
}
