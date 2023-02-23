//
//  ProductsNavigationLink.swift
//  Products-App
//
//  Created by Peter Murin on 23/02/2023.
//

import SwiftUI

struct ProductsNavigationLink: View {
    let product: Product
    
    var body: some View {
        NavigationLink(destination: ProductDetailView(productId: product.id)) {
            HStack {
                MainImage(url: product.image)
                    .frame(maxWidth: 60, maxHeight: 60)
                
                VStack(alignment: .leading) {
                    Text(product.title)
                    
                    Text(product.category)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct ProductsNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        ProductsNavigationLink(product: Product(id: 0, title: "", price: 0, description: "", category: "", image: "", rating: Rating(rate: 0, count: 0)))
    }
}
