//
//  CharacterImageView.swift
//  RickAndMorty
//
//  Created by Piotr Kłobukowski on 18/02/2024.
//

import SwiftUI

struct CharacterImageView: View {
    @State var urlString: String
    
    var body: some View {
        AsyncImage(url: URL(string: urlString)!) { image in
            image
                .resizable()
        } placeholder: {
            ProgressView()
                .controlSize(.large)
        }
        .frame(width: 300, height: 300)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
    }
}

#Preview {
    CharacterImageView(urlString: "https://rickandmortyapi.com/api/character/avatar/12.jpeg")
}
