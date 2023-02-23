//
//  ProductView.swift
//  Products-App
//
//  Created by Peter Murin on 22/02/2023.
//

import SwiftUI

struct ProductView: View {
    @EnvironmentObject var productManager: ProductManager
    @State private var filterValue: String = ""
    @State private var filterActivated: Bool = false
    
    var body: some View {
        List(productManager.products.filter({ product in
            product.category.localizedCaseInsensitiveContains(filterValue) || filterValue.isEmpty
        }), id: \.id) { product in
            NavigationLink(destination: ProductDetailView(productId: product.id)) {
                HStack {
                    AsyncImage(url: URL(string: product.image)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 60, maxHeight: 60)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 60, maxHeight: 60)
                        @unknown default:
                            // Since the AsyncImagePhase enum isn't frozen,
                            // we need to add this currently unused fallback
                            // to handle any new cases that might be added
                            // in the future:
                            EmptyView()
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text(product.title)
                        
                        Text(product.category)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .task {
            do {
                try await productManager.loadProducts()
                try await productManager.loadProductCategories()
            } catch {
                print("\n\(error.localizedDescription)\n")
            }
        }
        .listStyle(.plain)
        .searchable(text: $filterValue)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Products")
                    .font(.headline)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    filterActivated = true
                } label: {
                    Text("Filter")
                }
                .confirmationDialog("", isPresented: $filterActivated) {
                    if !filterValue.isEmpty {
                        Button("Cancel filter \(filterValue)", role: .destructive) {
                            filterValue = ""
                            filterActivated = false
                        }
                    }
                    
                    ForEach(productManager.productCategories, id: \.self) { category in
                        if filterValue != category {
                            Button(category) {
                                filterValue = category
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    @StateObject static var productManager = ProductManager();
    
    static var previews: some View {
        ProductView()
            .environmentObject(productManager)
    }
}
