//
//  EpisodeDetailsView.swift
//  RickAndMorty
//
//  Created by Piotr Kłobukowski on 17/02/2024.
//

import SwiftUI

struct EpisodeDetailsView: View {
    @ObservedObject var viewModel: EpisodeDetailsViewModel
    
    var body: some View {
        VStack {
            PropertyTextView(propertyText:"Name", value: viewModel.episode.name)
            PropertyTextView(propertyText:"Air_date", value: viewModel.episode.air_date)
            PropertyTextView(propertyText:"Episode",  value: viewModel.episode.episode)
            PropertyTextView(propertyText:"Characters count", value: "\(viewModel.charactersCount)")
            Spacer()
        }
    }
}

#Preview {
    EpisodeDetailsView(viewModel: EpisodeDetailsViewModel(episode: Episode(id: 1, name: "Rick Potion #9", air_date: "January 27, 2014", episode: "S01E06", characters: ["Rick", "Morty"]))
    )
}
