//
//  SearchBarView.swift
//  Movie Time
//
//  Created by Ming Liang Khong on 24/6/22.
//

import SwiftUI

struct SearchBarView: View {
    let performSearch: (String) -> Void
    @State private var textInput = ""
    var body: some View {
        HStack (alignment: .center) {
            TextField( "Search", text: $textInput)
                .padding(4.0)
                .overlay(RoundedRectangle(cornerRadius: 5.0).stroke())
                .padding()
            Button(
                action: {
                    performSearch(textInput)
                    hideKeyboard()
                }) {
                    Image(systemName: "magnifyingglass.circle.fill").font(.system(size: 32.0))
                }
                .padding(.trailing)
        }
        .background(
            Color.white
                .ignoresSafeArea()
                .shadow(color: .gray.opacity(0.5), radius: 2, x: 0.0, y: 4.0)
        )
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView { searchTerm in
            print(searchTerm)
        }
    }
}
