//
//  MainManager.swift
//  Products-App
//
//  Created by Peter Murin on 22/02/2023.
//

import Foundation

@MainActor
class ProductManager: ObservableObject {
    @Published var productsErrorMessage: String = ""
    @Published var productCategoriesErrorMessage: String = ""
    @Published var products: [Product] = []
    @Published var productCategories: [String] = []
    
    let networkAPI = NetworkAPI()
    
    func fetchProducts() async {
        productsErrorMessage = ""
        
        if let res = await networkAPI.getProducts() {
            products = res
        } else {
            productsErrorMessage = "Fetch data failed"
        }
    }
    
    func fetchProductCategories() async {
        productCategoriesErrorMessage = ""
        
        if let res = await networkAPI.getProductCategories() {
            productCategories = res
        } else {
            productCategoriesErrorMessage = "Fetch data failed"
        }
    }
}
