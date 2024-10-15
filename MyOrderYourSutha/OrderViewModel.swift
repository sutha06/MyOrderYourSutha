//
//  OrderViewModel.swift
//  MyOrderYourSutha
//
//  991703674
//  Created by Suthakaran Siva on 2024-10-10.
//

import Foundation
import CoreData
class OrderViewModel : ObservableObject {
    
    @Published  var pizzaOrders : [PizzaOrder] = []
  let viewContext : NSManagedObjectContext
    
    init(){
        viewContext = PersistenceController().container.viewContext
        
        fetchPizzaOrder()
    }
    
    func fetchPizzaOrder() {
            let request = NSFetchRequest<PizzaOrder>(entityName: "PizzaOrder")
        
            do {
                pizzaOrders = try viewContext.fetch(request)
            } catch {
                print("Error fetching orders: \(error)")
            }
        }

    
    
    fileprivate func SaveData() {
        do {
            try viewContext.save()
            print("done")
        }catch{
            print("error")
        }
    }
    
    func addPizzaOrder( pizza_type :String , size :String , quantity :String, date : Date, crust_type: String){
        
        let pizzaOrder = PizzaOrder(context: viewContext)
        pizzaOrder.id = UUID()
        pizzaOrder.pizza_type = pizza_type
        pizzaOrder.size = size
        pizzaOrder.quantity = Int16(quantity) ?? 0
        pizzaOrder.date = date
        pizzaOrder.crust_type = crust_type
        
        SaveData()
        
        fetchPizzaOrder()
    }
    
    // function for deleting an order from the list
    func deletePizzaOrder( indexSet : IndexSet){
        
        for index in indexSet {
            
            let pizzaOrder = pizzaOrders[index]
            viewContext.delete(pizzaOrder)
            SaveData()
            fetchPizzaOrder()
        }
    }
    
    
    func updatePizzaOrder( id : UUID , newpizza_type :String , newSize :String , newQuantity :String , newDate : Date, newcrust_type : String){
        
        
        for pizzaOrder in pizzaOrders {
            if pizzaOrder.id == id{
                pizzaOrder.pizza_type = newpizza_type
                pizzaOrder.size = newSize
                pizzaOrder.quantity = Int16(newQuantity) ?? 0
                pizzaOrder.date = newDate
                pizzaOrder.crust_type = newcrust_type
            }
        }
        
        SaveData()
        fetchPizzaOrder()
    }
}


