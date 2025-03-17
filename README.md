# MercadoLibre Search App

A SwiftUI-based search application for MercadoLibre, featuring a clean UI, animations, and networking.

## 🚀 Features

SwiftUI interface with NavigationView and animations

Custom search bar and loading indicator

Product list with navigation to detail view

Async image loading

MVVM architecture with Combine

## 📦 Installation

Clone this repository:

git clone https://github.com/cfalvarezb/MercadoLibreSearch.git

Open the project in Xcode.

Run the project on a simulator or device.

## 🏗️ Architecture

This app follows the MVVM (Model-View-ViewModel) pattern:

ContentView.swift: Main view with search bar and product list

ProductDetailView.swift: Product details view

SearchViewModel.swift: Handles search logic and API calls

Product.swift: Data model for products

SearchInteractor.swift: Handles network requests

## 📜 Code Overview

ContentView

Defines the main UI, handling search and displaying results:

struct ContentView: View {
    @StateObject private var viewModel = SearchViewModel()

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchQuery, onSearch: viewModel.search)
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    List(viewModel.products) { product in
                        NavigationLink(destination: ProductDetailView(product: product)) {
                            ProductRow(product: product)
                        }
                    }
                }
            }
        }
    }
}

SearchViewModel

Handles search logic and API calls using Combine:

class SearchViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false

    func search() {
        guard !searchQuery.isEmpty else { return }
        isLoading = true
        // API call logic here
    }
}

## 🔗 API Integration

The app fetches product data from:

https://worker-challenge-meli.jsagredo-ing-meli.workers.dev/sites/MLA/search?q={query}

The response is mapped to the Product model.

## 🛠️ Requirements

Xcode 14+

iOS 15+

Swift 5+

## 👥 Contributors

Your Name - GitHub

## 📄 License

This project is licensed under the MIT License.
