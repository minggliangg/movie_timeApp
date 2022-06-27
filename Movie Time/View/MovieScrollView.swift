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
    
    fileprivate func buildFooter() -> some View {
        if viewModel.hasNoResult{
            return AnyView (Text("No results, try another search!"))
        } else if viewModel.movies.isEmpty{
            return AnyView(Text("Search for a movie!"))
        } else if viewModel.isEndOfResult{
            return AnyView (Text("End of results!"))
        } else if !viewModel.isEndOfResult{
            return AnyView(ProgressView())
        }
        return AnyView(EmptyView())
    }
    
    var body: some View {
        ScrollView {
            ScrollViewReader { reader in
                LazyVGrid(columns: [GridItem(.fixed(columnWidth)),GridItem(.fixed(columnWidth))], alignment: .center, pinnedViews: .sectionHeaders) {
                    Section(
                        header: SearchBarView(performSearch: { searchTerm in
                            Task {
                                await self.viewModel.performSearch(on: searchTerm)
                                withAnimation {
                                    reader.scrollTo(1,anchor: .bottom)
                                }
                               
                            }
                        }),footer: buildFooter()
                    ) {
                        let movies = viewModel.movies
                        if movies.count > 0 {
                            EmptyView().id(1)
                            ForEach(0...(movies.count - 1), id: \.self) { i in
                                MovieItemView(title: movies[i].Title,imageUrl: movies[i].Poster, width: columnWidth)
                                    .id(movies[i].id)
                                    .onAppear {
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

