//
//  CharactersListViewModel.swift
//  RickAndMorty
//
//  Created by Piotr Kłobukowski on 16/02/2024.
//

import Foundation

final class CharactersListViewModel: ObservableObject {
    @Published var characters: [Character]? = nil
    @Published var error: APIError? = nil
    @Published var isLoading = false
    @Published var allCharactersLoaded = false
    var favourites: [Int] {
        userDefaults.favourites
    }
    
    let apiClient: APIClient
    let userDefaults: UserDefaultsHandler
    
    init(apiClient: APIClient, userDefaults: UserDefaultsHandler) {
        self.apiClient = apiClient
        self.userDefaults = userDefaults
    }

    var url: URL? = URLConstructor.defaultCharactersUrl()
    
    func loadCharacters() async {
        guard let url else { return }
        let resultWithResponse = await apiClient.load(for: Response.self, from: url)
        switch resultWithResponse {
        case .success(let response):
            if let nextUrlString = response.info.next {
                self.url = URL(string: nextUrlString)
            } else {
                self.url = nil
            }
            await MainActor.run {
                if characters != nil {
                    characters?.append(contentsOf: response.results)
                } else {
                    characters = response.results
                }
                allCharactersLoaded = characters?.count == response.info.count
            }
        case .failure(let loadError):
            await MainActor.run {
                self.error = loadError
            }
        }
    }
    
    func cancelRequest() {
        URLSession.shared.invalidateAndCancel()
    }
    
    func clearList() {
        isLoading = false
        characters = nil
        error = nil
        url = URLConstructor.defaultCharactersUrl()
    }
}
