//
//  Character.swift
//  RickAndMorty
//
//  Created by Piotr Kłobukowski on 16/02/2024.
//

import Foundation

struct Character: Decodable, Identifiable {
    let id: Int
    let name: String
}
