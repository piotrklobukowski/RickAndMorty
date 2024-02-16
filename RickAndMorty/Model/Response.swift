//
//  Response.swift
//  RickAndMorty
//
//  Created by Piotr Kłobukowski on 16/02/2024.
//

import Foundation

struct Response: Decodable {
    let info: Info
    let results: [Character]
}
