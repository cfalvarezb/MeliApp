//
//  ProductDetailView.swift
//  MeliApp
//
//  Created by mac_user  on 15/03/25.
//

import SwiftUI
import Combine

struct ProductDetailView: View {
    let product: Product
    
    var body: some View {
        ScrollView {
            VStack {
                
                AsyncImage(url: URL(string: product.thumbnail)) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .padding(.top)
                .frame(height: 300)
                .transition(.opacity)
                .animation(.easeInOut(duration: 0.5), value: product.id)
                
                Text(product.title)
                    .font(.title)
                    .foregroundColor(.mercadoLibreBlue)
                    .padding()
                    .lineLimit(nil) // Ensures text wraps to multiple lines
                    .multilineTextAlignment(.center) // Centers text if it wraps
                    .minimumScaleFactor(0.8) // Scales down text if it overflows
                    .transition(.slide)
                    .animation(.spring(), value: product.title)
                
                Text(String(format: Localized.productPrice, product.price))
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding()
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut(duration: 0.5), value: product.price)
            }
            .frame(maxWidth: .infinity)
            .padding(.all)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensures VStack fills the entire screen
        .padding(.top)
        .navigationTitle(Localized.productDetailTitle)
        .font(.mercadoLibreFont).accessibilityIdentifier("ProductDetailTitle")
        .background(Color.mercadoLibreYellow.edgesIgnoringSafeArea(.all))
    }

}


#Preview {
    ProductDetailView(product: Product(id: "MLA1116621831", title: "Apple iPhone 13 (128 Gb) - Azul - Distribuidor Autorizado", price: 1874999, thumbnail: "http://http2.mlstatic.com/D_619667-MLA47781882790_102021-I.jpg"))
}
