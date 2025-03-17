//
//  Product.swift
//  MeliApp
//
//  Created by mac_user  on 15/03/25.
//

import Foundation

struct Product: Identifiable, Codable, Equatable {
    let id: String
    let title: String
    let price: Double
    let thumbnail: String
}
