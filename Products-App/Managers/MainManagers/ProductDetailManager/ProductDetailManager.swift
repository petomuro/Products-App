//
//  ProductDetailManager.swift
//  Products-App
//
//  Created by Peter Murin on 22/02/2023.
//

import Foundation

@MainActor
class ProductDetailManager: ObservableObject {
    @Published var errorMessage: String = ""
    @Published var productDetails: Product?
    
    let networkAPI = NetworkAPI()
    
    func fetchProductDetails(_ productId: Int) async {
        errorMessage = ""
        
        if let res = await networkAPI.getProductDetails(productId) {
            productDetails = res
        } else {
            errorMessage = "Fetch data failed"
        }
    }
    
}
