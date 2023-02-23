//
//  ProductDetail.swift
//  Products-App
//
//  Created by Peter Murin on 23/02/2023.
//

import SwiftUI

struct ProductDetail: View {
    @EnvironmentObject var productDetailManager: ProductDetailManager
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            HStack {
                Spacer()
                
                MainImage(url: productDetailManager.productDetails?.image ?? "")
                    .padding(.bottom)
                    .frame(maxWidth: 200, maxHeight: 200)
                
                Spacer()
            }
            
            Text(productDetailManager.productDetails?.title ?? "")
                .font(.headline)
                .padding(.bottom)
                .foregroundColor(.blue)
            
            Text(productDetailManager.productDetails?.description ?? "")
                .font(.footnote)
                .padding(.bottom)
                .foregroundColor(.secondary)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Product ID")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    
                    Text(String(productDetailManager.productDetails?.id ?? 0))
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Price")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    
                    Text("\(productDetailManager.productDetails?.price ?? 0, specifier: "%.2f")€")
                }
            }
            
            Spacer()
        }
    }
}

struct ProductDetail_Previews: PreviewProvider {
    @StateObject static var productDetailManager = ProductDetailManager()
    
    static var previews: some View {
        ProductDetail()
            .environmentObject(productDetailManager)
    }
}
