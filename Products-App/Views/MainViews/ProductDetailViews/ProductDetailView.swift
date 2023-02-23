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
        VStack(alignment: .leading) {
            Spacer()
            
            HStack {
                Spacer()
                
                AsyncImage(url: URL(string: productDetailManager.productDetails?.image ?? "")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 200, maxHeight: 200)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 200, maxHeight: 200)
                    @unknown default:
                        // Since the AsyncImagePhase enum isn't frozen,
                        // we need to add this currently unused fallback
                        // to handle any new cases that might be added
                        // in the future:
                        EmptyView()
                    }
                }
                .padding(.bottom)
                
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
        .padding()
        .task {
            do {
                try await productDetailManager.loadProductDetails(productId)
            } catch {
                print("\n\(error.localizedDescription)\n")
            }
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    @StateObject static var productDetailManager = ProductDetailManager();
    
    static var previews: some View {
        ProductDetailView(productId: 1)
            .environmentObject(productDetailManager)
    }
}
