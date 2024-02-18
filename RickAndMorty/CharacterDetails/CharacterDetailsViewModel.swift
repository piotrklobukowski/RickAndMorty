//
//  CharacterDetailsViewModel.swift
//  RickAndMorty
//
//  Created by Piotr Kłobukowski on 17/02/2024.
//

import Foundation

final class CharacterDetailsViewModel: ObservableObject {
    @Published var character: Character
    @Published var episodes: Result<[Episode], APIError>? = nil
    @Published var isFavourite: Bool = false {
        didSet {
            userDefaultsHandler.setCharacterAsFavourite(with: character.id)
        }
    }
    
    let apiClient: APIClient
    let userDefaultsHandler: UserDefaultsHandler
    
    init(character: Character, isFavourite: Bool, apiClient: APIClient, userDefaultsHandler: UserDefaultsHandler) {
        self.character = character
        self.isFavourite = isFavourite
        self.apiClient = apiClient
        self.userDefaultsHandler = userDefaultsHandler
    }
    
    func fetchEpisodes() async {
        var episodesIds = provideEpisodesIds()
        let url = URLConstructor.episodeUrl(for: episodesIds)
        let loadedEpisodesResult = await apiClient.load(for: [Episode].self, from: url)
        await MainActor.run {
            episodes = loadedEpisodesResult
        }
    }
    
    private func provideEpisodesIds() -> String {
        var episodesIds = character.episode.reduce("[", { partialResult, episodeUrl in
            let firstDigit = episodeUrl.index(after: episodeUrl.lastIndex(of: "/")!)
            let episodeNumber = String(episodeUrl[firstDigit...])
            return partialResult + episodeNumber + ","
        })
        episodesIds.removeLast()
        episodesIds += "]"
        return episodesIds
    }
}
