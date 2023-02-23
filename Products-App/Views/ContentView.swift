//
//  ContentView.swift
//  Products-App
//
//  Created by Peter Murin on 22/02/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var productManager = ProductManager();
    @StateObject private var productDetailManager = ProductDetailManager();
    
    var body: some View {
        MainView()
            .environmentObject(productManager)
            .environmentObject(productDetailManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
