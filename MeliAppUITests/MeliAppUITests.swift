//
//  MeliAppUITests.swift
//  MeliAppUITests
//
//  Created by mac_user  on 14/03/25.
//
import XCTest

class MeliAppUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testSearchFlow() throws {
        let app = XCUIApplication()
        app.launch()
        
        let searchField = app.textFields["SearchBarTextField"]
        XCTAssertTrue(searchField.exists, "Search field should exist")
        
        searchField.tap()
        searchField.typeText("iPhone")
        
        let searchButton = app.buttons["SearchButton"] // <-- Usar el nuevo identificador
        XCTAssertTrue(searchButton.waitForExistence(timeout: 5), "Search button should exist")
        searchButton.tap()
        
        let productCell = app.cells.firstMatch
        XCTAssertTrue(productCell.waitForExistence(timeout: 10), "Product cell should appear")
    }
    
    
    func testDetailView() throws {
        let app = XCUIApplication()
        app.launch()
        
        let searchField = app.textFields["SearchBarTextField"]
        XCTAssertTrue(searchField.exists, "Search field should exist")
        
        searchField.tap()
        searchField.typeText("iPhone")
        
        let searchButton = app.buttons["SearchButton"] // <-- Usar el nuevo identificador
        XCTAssertTrue(searchButton.waitForExistence(timeout: 5), "Search button should exist")
        searchButton.tap()
        
        let productCell = app.cells.element(boundBy: 0)
        XCTAssertTrue(productCell.waitForExistence(timeout: 5), "Product cell should appear")
        
        productCell.tap()
        
        let detailTitle = app.staticTexts["ProductDetailTitle"]
        XCTAssertTrue(detailTitle.waitForExistence(timeout: 5), "Detail screen should be displayed")
    }
}

