//
//  ProductDetailManager.swift
//  Products-App
//
//  Created by Peter Murin on 22/02/2023.
//

import Foundation

@MainActor
class ProductDetailManager: ObservableObject {
    @Published var productDetails: Product?
    
    func loadProductDetails(_ productId: Int) async throws {
        guard let url = URL(string: "https://fakestoreapi.com/products/\(productId)") else {
            print("\nBad URL\n")
            
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("\nError while fetching data\n")
        }
        
        self.productDetails = try JSONDecoder().decode(Product.self, from: data)
    }
    
}
