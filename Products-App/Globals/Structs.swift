//
//  Structs.swift
//  Products-App
//
//  Created by Peter Murin on 22/02/2023.
//

import Foundation

struct Rating: Codable {
    let rate: Float
    let count: Int
}

struct Product: Codable  {
    let id: Int
    let title: String
    let price: Float
    let description: String
    let category: String
    let image: String
    let rating: Rating
}
