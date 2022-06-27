//
//  MovieScrollViewModel.swift
//  Movie Time
//
//  Created by Ming Liang Khong on 24/6/22.
//

import Foundation
@MainActor
class MovieScrollViewModel: ObservableObject {
    
    let networkManager = NetworkManager.shared
    
    @Published var movies: [Movie] = []
    @Published var totalResult = 0
    @Published var currentPage = 0
    
    private var currentSearchTerm = ""
    
    func performSearch(on searchTerm: String) async {
        
        if let movieScrollModel = await  networkManager.getMovies(searchTerm: searchTerm, page: 0) {
            self.movies = movieScrollModel.movies
            self.totalResult = movieScrollModel.totalResult
            self.currentPage = movieScrollModel.currentPage
        }
        
        currentSearchTerm = searchTerm
    }
    
    func fetchData() async {
        if currentPage * 10 >= totalResult {
            print ("end of results")
            return
        }
        if let movieScrollModel = await  networkManager.getMovies(searchTerm: currentSearchTerm,page: self.currentPage) {
            self.movies.append(contentsOf: movieScrollModel.movies)
            self.totalResult = movieScrollModel.totalResult
            self.currentPage = movieScrollModel.currentPage
        }
    }
    
    func getSearchTerm() -> String {
        return currentSearchTerm
    }
    
    
    
}
