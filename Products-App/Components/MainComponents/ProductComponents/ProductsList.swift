//
//  ProductsList.swift
//  Products-App
//
//  Created by Peter Murin on 23/02/2023.
//

import SwiftUI

struct ProductsList: View {
    @Binding var filterValue: String
    @Binding var filterActivated: Bool
    @EnvironmentObject var productManager: ProductManager
    
    var body: some View {
        List(productManager.products.filter({ product in
            product.category.localizedCaseInsensitiveContains(filterValue) || filterValue.isEmpty
        }), id: \.id) { product in
            ProductsNavigationLink(product: product)
        }
        .listStyle(.plain)
        .searchable(text: $filterValue)
        .refreshable {
            await productManager.fetchProducts()
        }
    }
}

struct ProductsList_Previews: PreviewProvider {
    @StateObject static var productManager = ProductManager()
    
    static var previews: some View {
        ProductsList(filterValue: .constant(""), filterActivated: .constant(false))
            .environmentObject(productManager)
    }
}
