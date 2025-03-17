//
//  SearchInteractor.swift
//  MeliApp
//
//  Created by mac_user  on 15/03/25.
//

import Foundation
import Combine

// MARK: - Interactor
protocol SearchInteractorProtocol {
    func fetchProducts(query: String) -> AnyPublisher<[Product], Error>
}

class SearchInteractor: SearchInteractorProtocol {
    func fetchProducts(query: String) -> AnyPublisher<[Product], Error> {
        let urlString = "https://worker-challenge-meli.jsagredo-ing-meli.workers.dev/sites/MLA/search?q=\(query)"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: SearchResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .eraseToAnyPublisher()
    }
}
