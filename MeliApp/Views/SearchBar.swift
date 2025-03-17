//
//  SearchBar.swift
//  MeliApp
//
//  Created by mac_user  on 15/03/25.
//

import SwiftUI
import Combine

struct SearchBar: View {
    @Binding var text: String
    var onSearch: () -> Void
    
    var body: some View {
        HStack {
            TextField(Localized.searchPlaceholder, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 3)
                .transition(.move(edge: .leading).combined(with: .opacity))
                .animation(.easeInOut(duration: 0.5), value: text)
                .accessibilityIdentifier("SearchBarTextField") //Assign an identifier
            
            Button(action: onSearch) {
                Image(systemName: "magnifyingglass")
                    .padding()
                    .background(Circle().fill(Color.mercadoLibreBlue))
                    .foregroundColor(.white)
                    .scaleEffect(1.0)
                    .animation(.spring(), value: text)
            }
            .accessibilityIdentifier("SearchButton") // Identificador único
        }
    }
}

struct RefreshControl: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIRefreshControl {
        let control = UIRefreshControl()
        control.addTarget(context.coordinator, action: #selector(Coordinator.handleRefresh), for: .valueChanged)
        return control
    }
    
    func updateUIView(_ uiView: UIRefreshControl, context: Context) {}
    
    class Coordinator {
        var control: RefreshControl
        
        init(_ control: RefreshControl) {
            self.control = control
        }
        
        @objc func handleRefresh(sender: UIRefreshControl) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                sender.endRefreshing()
            }
        }
    }
}
