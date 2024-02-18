//
//  Episode.swift
//  RickAndMorty
//
//  Created by Piotr Kłobukowski on 17/02/2024.
//

import Foundation

struct Episode: Codable, Identifiable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
}
