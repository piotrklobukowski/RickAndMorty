//
//  UserDefaultsHandler.swift
//  RickAndMorty
//
//  Created by Piotr Kłobukowski on 18/02/2024.
//

import Foundation

final class UserDefaultsHandler: ObservableObject {
    @Published var favourites: [Int] = [] {
        didSet {
            UserDefaults.standard.set(favourites, forKey: Constants.favouriteCharactersKey)
        }
    }
    
    func setCharacterAsFavourite(with id: Int) {
        if favourites.contains(id) {
            favourites.removeAll { $0 == id }
        } else {
            favourites.append(id)
        }
    }
    
    init() {
        self.favourites = UserDefaults.standard.value(forKey: Constants.favouriteCharactersKey) as? [Int] ?? []
    }
}
