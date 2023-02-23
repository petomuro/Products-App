//
//  NetworkAPI.swift
//  Products-App
//
//  Created by Peter Murin on 23/02/2023.
//

import Foundation

class NetworkAPI: NetworkManager {
    func getProducts() async -> [Product]? {
        do {
            let data = try await get("/products")
            let result: [Product] = try parseData(data)
            
            return result
        } catch let error {
            print("\n\(error.localizedDescription)\n")
            
            return nil
        }
    }
    
    func getProductCategories() async -> [String]? {
        do {
            let data = try await get("/products/categories")
            let result: [String] = try parseData(data)
            
            return result
        } catch let error {
            print("\n\(error.localizedDescription)\n")
            
            return nil
        }
    }
    
    func getProductDetails(_ productId: Int) async -> Product? {
        do {
            let data = try await get("/products/\(productId)")
            let result: Product = try parseData(data)
            
            return result
        } catch let error {
            print("\n\(error.localizedDescription)\n")
            
            return nil
        }
    }
    
    private func parseData<T: Decodable>(_ data: Data) throws -> T {
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            throw NSError(
                domain: "NetworkAPIError",
                code: 3,
                userInfo: [NSLocalizedDescriptionKey: "JSON decode error"]
            )
        }
        
        return decodedData
    }
}
