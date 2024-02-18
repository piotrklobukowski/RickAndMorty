//
//  PropertyTextView.swift
//  RickAndMorty
//
//  Created by Piotr Kłobukowski on 18/02/2024.
//

import SwiftUI

struct PropertyTextView: View {
    @State var propertyText: String
    @State var value: String
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(propertyText)
                    .bold()
                Text(value)
                Spacer()
            }
            Divider()
                .padding(.horizontal)
        }
    }
}

#Preview {
    PropertyTextView(propertyText: "Origin", value: "Earth")
}
