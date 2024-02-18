//
//  URLConstructor.swift
//  RickAndMorty
//
//  Created by Piotr Kłobukowski on 18/02/2024.
//

import Foundation

struct URLConstructor {
    static func episodeUrl(for ids: String) -> URL {
        return URL(string: Constants.baseUrl + "episode/" + ids)!
    }
    
    static func defaultCharactersUrl() -> URL {
        return URL(string: Constants.baseUrl + "character")!
    }
}
