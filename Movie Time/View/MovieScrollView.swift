//
//  MovieScrollView.swift
//  Movie Time
//
//  Created by Ming Liang Khong on 24/6/22.
//

import SwiftUI

struct MovieScrollView: View {
    @StateObject var viewModel = MovieScrollViewModel()
    let columnWidth: Double
    var body: some View {
        ScrollView {
            ScrollViewReader { reader in
                LazyVGrid(columns: [GridItem(.fixed(columnWidth)),GridItem(.fixed(columnWidth))], alignment: .center, pinnedViews: .sectionHeaders) {
                    Section(
                        header: SearchBarView(performSearch: { searchTerm in
                          Task {
                              await self.viewModel.performSearch(on: searchTerm)
                            }
                           
                        })
                    ) {
                        let movies = viewModel.movies
                        if movies.count > 0 {
                            ForEach(0...(movies.count - 1), id: \.self) { i in
                                MovieItemView(title: movies[i].Title,imageUrl: movies[i].Poster, width: columnWidth).onAppear {
                                    if (viewModel.movies.count - 1) == i {
                                        Task {
                                            await self.viewModel.fetchData()
                                        }
                                        
                                    }
                                }
                            }.padding()
                        }
                    }
                }
            }
          
        }.gesture(DragGesture().onChanged({ _ in
            hideKeyboard()
        }))
        .onTapGesture {
            hideKeyboard()
        }.onAppear{
            Task {
                await self.viewModel.fetchData()
            }
           
        }
    }
}

struct MovieScrollView_Previews: PreviewProvider {
    static var previews: some View {
        MovieScrollView(columnWidth: 200).previewLayout(.sizeThatFits)
    }
}

