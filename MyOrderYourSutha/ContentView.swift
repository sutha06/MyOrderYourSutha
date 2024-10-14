import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: OrderViewModel
    
    @State private var selectedSize = ""
    @State private var selectedToppings = ""
    @State private var selectedCrust = ""
    @State private var pizzaAmount: Double = .zero

    let pizzaSizes = ["Small", "Medium", "Large"]
    let pizzaToppings = ["Cheese", "Pepperoni", "Veggie", "Meat Lovers", "Hawaiian"]
    let crustTypes = ["Thin", "Regular", "Thick"]

    var body: some View {
        NavigationView {
            Form {
                Section("Make Your Order") {
                    Picker("Pick a Size", selection: $selectedSize) {
                        ForEach(pizzaSizes, id: \.self) { item in
                            Text(item)
                        }
                    }

                    Picker("Toppings", selection: $selectedToppings) {
                        ForEach(pizzaToppings, id: \.self) { item in
                            Text(item)
                        }
                    }

                    Picker("Crust Type", selection: $selectedCrust) {
                        ForEach(crustTypes, id: \.self) { item in
                            Text(item)
                        }
                    }

                    Text("Amount of Pizza: \(Int(pizzaAmount))")
                    Slider(value: $pizzaAmount, in: 0...10) {
                        Text("Slider")
                    } minimumValueLabel: {
                        Text("0").font(.title2).fontWeight(.thin)
                    } maximumValueLabel: {
                        Text("10").font(.title2).fontWeight(.thin)
                    }
                    .tint(.red)
                    .padding()

                    Button("Make Order") {
                        viewModel.addPizzaOrder(
                            pizza_type: selectedToppings,
                            size: selectedSize,
                            quantity: String(Int(pizzaAmount)),
                            date: Date(),
                            crust_type: selectedCrust
                        )
                       
                        // Reset selections
                        selectedSize = ""
                        selectedToppings = ""
                        selectedCrust = ""
                        pizzaAmount = 0
                    }
                }
            }
            .navigationTitle("Suthas Pizza Shop")
        }
    }
}

#Preview {
    ContentView(viewModel: OrderViewModel())
}
