//
//  CharactersListView.swift
//  RickAndMorty
//
//  Created by Piotr Kłobukowski on 15/02/2024.
//

import SwiftUI

struct CharactersListView: View {
    var body: some View {
        VStack {
            Text("Tap button below to load list of characters from Rick and Morty sitcom")
                .multilineTextAlignment(.center)
                .padding()
            Button("Load characters") {
                
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    CharactersListView()
}
