//
//  ProductRow.swift
//  MeliApp
//
//  Created by mac_user  on 15/03/25.
//

import SwiftUI
import Combine

struct ProductRow: View {
    let product: Product
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.3), value: product.id)
            
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.headline)
                    .foregroundColor(.mercadoLibreBlue)
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.green)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
        .accessibilityIdentifier("ProductCell_\(product.id)") // <-- Agrega identificador único
    }
}

#Preview {
    ProductRow(product: Product(id: "MLA1116621831", title: "Apple iPhone 13 (128 Gb) - Azul - Distribuidor Autorizado", price: 1874999, thumbnail: "http://http2.mlstatic.com/D_619667-MLA47781882790_102021-I.jpg"))
}
