//
//  User.swift
//  EgnyteTest
//
//  Created by Aadil Majeed on 01/10/22.
//

import Foundation

struct User: Codable {
    let id: String
    let urls: ImageURL
}


struct ImageURL: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
    let small_s3: String
}
