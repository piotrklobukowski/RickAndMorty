//
//  CharactersListView.swift
//  RickAndMorty
//
//  Created by Piotr Kłobukowski on 15/02/2024.
//

import SwiftUI

struct CharactersListView: View {
    @ObservedObject var viewModel: CharactersListViewModel
    
    var body: some View {
        let _ = Self._printChanges()
        NavigationView {
            if !viewModel.isLoading {
                VStack {
                    Text("Tap button below to load list of characters from Rick and Morty sitcom")
                        .multilineTextAlignment(.center)
                        .padding()
                    Button("Load characters") {
                        viewModel.isLoading = true
                        Task {
                            await viewModel.loadCharacters()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else {
                List {
                    if let characters = viewModel.characters {
                        ForEach(characters) { character in
                            NavigationLink {
                                CharacterDetailsView(viewModel: CharacterDetailsViewModel(character: character, isFavourite: viewModel.favourites.contains(character.id), apiClient: APIClient(), userDefaultsHandler: viewModel.userDefaults))
                            } label: {
                                HStack {
                                    Text(character.name)
                                    if viewModel.favourites.contains(character.id) {
                                        Image(systemName: "star.fill")
                                            .foregroundStyle(.yellow)
                                    }
                                }
                            }
                        }
                        if !viewModel.allCharactersLoaded {
                            ProgressViewWithResult(
                                localizedDescription: viewModel.error?.localizedDescription, onTapButtonAction: {
                                    Task {
                                        viewModel.cancelRequest()
                                        viewModel.error = nil
                                    }
                                }, onAppearAction: {
                                    Task {
                                        await viewModel.loadCharacters()
                                    }
                                })
                        }
                    } else {
                        ProgressViewWithResult(
                            localizedDescription: viewModel.error?.localizedDescription, onTapButtonAction: {
                                Task {
                                    viewModel.cancelRequest()
                                    viewModel.error = nil
                                }
                            }, onAppearAction: {
                                Task {
                                    await viewModel.loadCharacters()
                                }
                            })
                    }
                }
                .toolbar {
                    Button("Clear list") {
                        viewModel.clearList()
                    }
                }
                .navigationTitle("Characters List")
            }
        }
    }
}

#Preview {
    CharactersListView(viewModel: CharactersListViewModel(apiClient: APIClient(), userDefaults: UserDefaultsHandler()))
}
