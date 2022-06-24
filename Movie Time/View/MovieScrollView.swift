//
//  MovieScrollView.swift
//  Movie Time
//
//  Created by Ming Liang Khong on 24/6/22.
//

import SwiftUI

struct MovieScrollView: View {
    @ObservedObject var networkManager = NetworkManager.shared
    @State var textInput = ""
    let columnWidth: Double
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.fixed(columnWidth)),GridItem(.fixed(columnWidth))], alignment: .center, pinnedViews: .sectionHeaders) {
                
                Section(header: HStack (alignment: .center) {
                    TextField( "Search", text: $textInput)
                        .padding(4.0)
                        .overlay(RoundedRectangle(cornerRadius: 5.0).stroke())
                        .padding()
                    Button(action: {
                        print(textInput)
                        hideKeyboard()
                    }) {
                        Image(systemName: "magnifyingglass.circle.fill").font(.system(size: 32.0))
                    }}
                    .background(
                        Color.white
                            .ignoresSafeArea()
                            .shadow(color: .gray.opacity(0.5), radius: 2, x: 0.0, y: 4.0)
                    )) {
                        ForEach(networkManager.movies) { item in
                            MovieItemView(title: item.Title,imageUrl: item.Poster, width: columnWidth)
                        }.padding()
                    }
                
            }
        }.gesture(DragGesture().onChanged({ _ in
            hideKeyboard()
        }))
        .onTapGesture {
            hideKeyboard()
        }.onAppear{
            self.networkManager.fakeGetMovies(searchTerm: "Girl Who", page: 1)
        }
    }
}

struct MovieScrollView_Previews: PreviewProvider {
    static var previews: some View {
        MovieScrollView(columnWidth: 200).previewLayout(.sizeThatFits)
    }
}

