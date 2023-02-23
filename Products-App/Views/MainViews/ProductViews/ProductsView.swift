//
//  ProductsView.swift
//  Products-App
//
//  Created by Peter Murin on 22/02/2023.
//

import SwiftUI

struct ProductsView: View {
    @EnvironmentObject var productManager: ProductManager
    @State private var filterValue: String = ""
    @State private var filterActivated: Bool = false
    
    var body: some View {
        Group {
            if productManager.productsErrorMessage.isEmpty {
                ProductsList(filterValue: $filterValue, filterActivated: $filterActivated)
            } else {
                MainError(errorMessage: productManager.productsErrorMessage)
            }
        }
        .task {
            await productManager.fetchProducts()
            await productManager.fetchProductCategories()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle("Products")
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Products")
                    .font(.headline)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    filterActivated = true
                } label: {
                    Text("Filter")
                }
                .confirmationDialog("", isPresented: $filterActivated) {
                    if productManager.productsErrorMessage.isEmpty {
                        if !filterValue.isEmpty {
                            Button("Cancel filter \(filterValue)", role: .destructive) {
                                filterValue = ""
                                filterActivated = false
                            }
                        }
                        
                        ForEach(productManager.productCategories, id: \.self) { category in
                            if filterValue != category {
                                Button(category) {
                                    filterValue = category
                                }
                            }
                        }
                    } else {
                        MainError(errorMessage: productManager.productCategoriesErrorMessage)
                    }
                }
            }
        }
    }
}

struct ProductsView_Previews: PreviewProvider {
    @StateObject static var productManager = ProductManager()
    
    static var previews: some View {
        ProductsView()
            .environmentObject(productManager)
    }
}
