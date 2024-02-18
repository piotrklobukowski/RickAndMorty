//
//  ProgressViewWithResult.swift
//  RickAndMorty
//
//  Created by Piotr Kłobukowski on 18/02/2024.
//

import SwiftUI

struct ProgressViewWithResult: View {
    @State var localizedDescription: String?
    var onTapButtonAction: (() -> Void)
    var onAppearAction: (() -> Void)
    
    var body: some View {
        if let localizedDescription {
            Button(action: {
                onTapButtonAction()
            }, label: {
                VStack {
                    Text("Error: \(localizedDescription)")
                    Text("Tap to retry.")
                }
                .foregroundStyle(.white)
                .padding()
                .background(Color.red)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
            })
        } else {
            HStack {
                Spacer()
                ProgressView()
                    .controlSize(.large)
                    .onAppear {
                        onAppearAction()
                    }
                Spacer()
            }
        }
    }
}

#Preview {
    Group {
        ProgressViewWithResult(localizedDescription: "Internal server error", onTapButtonAction: {}, onAppearAction: {})
        ProgressViewWithResult(localizedDescription: nil, onTapButtonAction: {}, onAppearAction: {})
    }
}
