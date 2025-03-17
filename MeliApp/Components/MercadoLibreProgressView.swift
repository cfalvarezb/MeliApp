//
//  MercadoLibreProgressView.swift
//  MeliApp
//
//  Created by mac_user  on 15/03/25.
//

import SwiftUI

struct MercadoLibreProgressView: View {
    @State private var isAnimating = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Color.mercadoLibreBlue)
            .frame(width: isAnimating ? 200 : 50, height: 4)
            .animation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: isAnimating)
            .onAppear {
                isAnimating = true
            }
    }
}
