//
//  SearchViewModel.swift
//  MeliApp
//
//  Created by mac_user  on 15/03/25.
//

import Foundation
import Combine

// MARK: - ViewModel
class SearchViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var products: [Product] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let interactor: SearchInteractorProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: SearchInteractorProtocol = SearchInteractor()) {
        self.interactor = interactor
    }
    
    func search() {
        
        let valueTrimmed = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !searchQuery.isEmpty && !valueTrimmed.isEmpty else {
            DispatchQueue.main.async {
                self.errorMessage = Localized.errorEmptySearch
                self.isLoading = false
            }
            return
        }
        
        guard valueTrimmed.count >= 3 else {
            DispatchQueue.main.async {
                self.errorMessage = Localized.errorWordLessThreeCharactersSearch
                self.isLoading = false
            }
            return
        }

        DispatchQueue.main.async {
            self.isLoading = true
            self.errorMessage = nil
        }

        interactor.fetchProducts(query: searchQuery)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                DispatchQueue.main.async {
                    self?.isLoading = false
                }
                if case .failure(let error) = completion {
                    self?.errorMessage = "Error: \(error.localizedDescription)"
                }
            }, receiveValue: { [weak self] products in
                DispatchQueue.main.async {
                    self?.products = products
                }
            })
            .store(in: &cancellables)
    }
}

