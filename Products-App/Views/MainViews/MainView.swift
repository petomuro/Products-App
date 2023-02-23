//
//  MainView.swift
//  Products-App
//
//  Created by Peter Murin on 22/02/2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            ProductsView()
        }
        .navigationViewStyle(.stack)
    }
}

struct MainView_Previews: PreviewProvider {
    @StateObject static var productManager = ProductManager()
    @StateObject static var productDetailManager = ProductDetailManager()
    
    static var previews: some View {
        MainView()
            .environmentObject(productManager)
            .environmentObject(productDetailManager)
    }
}
