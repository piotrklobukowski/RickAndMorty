//
//  EpisodeDetailsViewModel.swift
//  RickAndMorty
//
//  Created by Piotr Kłobukowski on 17/02/2024.
//

import Foundation

final class EpisodeDetailsViewModel: ObservableObject {
    @Published var episode: Episode
    var charactersCount: Int { episode.characters.count }
    
    init(episode: Episode) {
        self.episode = episode
    }
}
