//
//  HomeView.swift
//  MyOrderYourSutha
//  991703674
//
//  Created by Suthakaran Siva on 2024-10-10.
//

import Foundation
import SwiftUICore
import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = OrderViewModel()
    
    var body: some View {
        TabView {
            ContentView(viewModel: viewModel)
                .tabItem {
                    Label {
                        Text("Order")
                            .font(.system(size: 16, weight: .bold))
                    } icon: {
                        Image(systemName: "cart")
                    }
                }
            
            OrderListView(viewModel: viewModel)
                .tabItem {
                    Label {
                        Text("View Orders")
                            .font(.system(size: 16, weight: .bold))
                    } icon: {
                        Image(systemName: "list.bullet")
                    }
                }
        }
    }
}

#Preview {
    HomeView()
}
