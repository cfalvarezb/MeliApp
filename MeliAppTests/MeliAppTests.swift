//
//  MeliAppTests.swift
//  MeliAppTests
//
//  Created by mac_user  on 14/03/25.
//

import XCTest
import Combine
@testable import MeliApp

class MeliAppTests: XCTestCase {
    var viewModel: SearchViewModel!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        viewModel = SearchViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func testSearchSuccess() {
        let expectation = XCTestExpectation(description: "Successful search fetch")
        viewModel.searchQuery = "iPhone"
        
        viewModel.$products
            .dropFirst()
            .sink { products in
                XCTAssertFalse(products.isEmpty, "Products should not be empty on success")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.search()
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testSearchFailure() {
        let expectation = XCTestExpectation(description: "Search should fail gracefully")
        viewModel.searchQuery = ""  // Simula búsqueda vacía
        
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                if let errorMessage = errorMessage {
                    XCTAssertFalse(errorMessage.isEmpty, "Error message should not be empty")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.search()
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLoadingState() {
        let expectation = XCTestExpectation(description: "Loading state should toggle correctly")
        viewModel.searchQuery = "Samsung"

        var loadingStates: [Bool] = []

        viewModel.$isLoading
            .sink { isLoading in
                loadingStates.append(isLoading)
            }
            .store(in: &cancellables)

        viewModel.search()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {  // Se da tiempo a la actualización
            XCTAssertTrue(loadingStates.contains(true), "isLoading should be true at the start")
            XCTAssertTrue(loadingStates.contains(false), "isLoading should be false at the end")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }
}

