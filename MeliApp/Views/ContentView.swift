//
//  ContentView.swift
//  MeliApp
//
//  Created by mac_user  on 15/03/25.
//

import SwiftUI

// MARK: - View
struct ContentView: View {
    @StateObject private var viewModel = SearchViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 0) { // Ensures elements don't shift around
                // SearchBar is fixed at the top
                if !viewModel.isLoading {
                    SearchBar(text: $viewModel.searchQuery, onSearch: viewModel.search)
                        .padding(.all)
                        .background(Color.mercadoLibreYellow.edgesIgnoringSafeArea(.top))
                        .shadow(radius: 3)
                }

                // Content below the search bar
                VStack {
                    if viewModel.isLoading {
                        ZStack {
                            Color.mercadoLibreYellow.edgesIgnoringSafeArea(.all)
                            GeometryReader { geometry in
                                Image("imageMeLi")
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(20)
                                    .frame(width: geometry.size.width * 0.5)
                                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2.5)

                                MercadoLibreProgressView()
                                    .transition(.scale)
                                    .animation(.spring(), value: viewModel.isLoading)
                                    .cornerRadius(20)
                                    .frame(width: geometry.size.width * 0.5)
                                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.2)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.mercadoLibreYellow.edgesIgnoringSafeArea(.all))
                    } else if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .transition(.opacity)
                            .animation(.easeIn, value: viewModel.errorMessage)
                            .padding(.top)
                            .background(Color.mercadoLibreYellow.edgesIgnoringSafeArea(.all))
                    } else {
                        List {
                            ForEach(viewModel.products) { product in
                                NavigationLink(destination: ProductDetailView(product: product)) {
                                    ProductRow(product: product)
                                        .transition(.slide)
                                        .animation(.easeInOut(duration: 0.3), value: viewModel.products)
                                }
                            }
                        }
                        .refreshable {
                            viewModel.search()
                        }
                        .background(Color.mercadoLibreYellow.edgesIgnoringSafeArea(.all))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.mercadoLibreYellow.edgesIgnoringSafeArea(.all))
            }
            .ignoresSafeArea(edges: .bottom) // Keeps the top area visible
            .navigationTitle(Localized.appName)
            .background(Color.mercadoLibreYellow.edgesIgnoringSafeArea(.all))
        }
        .background(Color.mercadoLibreYellow.edgesIgnoringSafeArea(.all))
    }
}


#Preview {
    ContentView()
}
