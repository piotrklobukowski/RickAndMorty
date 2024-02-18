//
//  CharacterDetailsView.swift
//  RickAndMorty
//
//  Created by Piotr Kłobukowski on 16/02/2024.
//

import SwiftUI

struct CharacterDetailsView: View {
    @ObservedObject var viewModel: CharacterDetailsViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                CharacterImageView(urlString: viewModel.character.image)
                PropertyTextView(propertyText: "Name", value: viewModel.character.name)
                PropertyTextView(propertyText: "Status", value: viewModel.character.status)
                PropertyTextView(propertyText: "Gender", value: viewModel.character.gender)
                PropertyTextView(propertyText: "Origin", value: viewModel.character.origin.name)
                switch viewModel.episodes {
                case .success(let episodes):
                    ForEach(episodes, id: \.id) { episode in
                        NavigationLink {
                            EpisodeDetailsView(viewModel: EpisodeDetailsViewModel(episode: episode))
                        } label: {
                            Text("Episode: \(episode.episode)")
                        }
                    }
                case .failure(let error):
                    Text("Error: \(error.localizedDescription)")
                case .none:
                    ProgressView()
                        .controlSize(.large)
                }
            }
        }
        .toolbar {
            Button(action: {
                viewModel.isFavourite.toggle()
            }, label: {
                Image(systemName: viewModel.isFavourite ? "star.fill" : "star")
                    .foregroundStyle(.yellow)
            })
        }
        .onAppear {
            if viewModel.episodes == nil {
                Task {
                    await viewModel.fetchEpisodes()
                }
            }
        }
    }
}
