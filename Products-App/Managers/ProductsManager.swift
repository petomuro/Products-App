//
//  MainManager.swift
//  Products-App
//
//  Created by Peter Murin on 22/02/2023.
//

import Alamofire
import Foundation

@MainActor
class ProductManager: ObservableObject {
    @Published var products: [Product] = []
    @Published var productCategories: [String] = []
    
    func loadProducts() async throws {        
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            print("\nBad URL\n")
            
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("\nError while fetching data\n")
        }
        
        self.products = try JSONDecoder().decode([Product].self, from: data)
    }
    
    func loadProductCategories() async throws {
        guard let url = URL(string: "https://fakestoreapi.com/products/categories") else {
            print("\nBad URL\n")
            
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("\nError while fetching data\n")
        }
        
        self.productCategories = try JSONDecoder().decode([String].self, from: data)
    }
}
