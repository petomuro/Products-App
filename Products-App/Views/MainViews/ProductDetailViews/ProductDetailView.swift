//
//  ProductDetailView.swift
//  Products-App
//
//  Created by Peter Murin on 22/02/2023.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var productDetailManager: ProductDetailManager
    
    let productId: Int
    
    var body: some View {
        Group {
            if productDetailManager.errorMessage.isEmpty {
                ProductDetail()
            } else {
                MainError(errorMessage: productDetailManager.errorMessage)
            }
        }
        .padding()
        .task {
            await productDetailManager.fetchProductDetails(productId)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(productDetailManager.productDetails?.category ?? "")
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(productDetailManager.productDetails?.category ?? "")
                    .font(.headline)
            }
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    @StateObject static var productDetailManager = ProductDetailManager()
    
    static var previews: some View {
        ProductDetailView(productId: 1)
            .environmentObject(productDetailManager)
    }
}
