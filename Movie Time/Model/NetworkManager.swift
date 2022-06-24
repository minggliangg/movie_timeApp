//
//  ApiService.swift
//  Movie Time
//
//  Created by Ming Liang Khong on 24/6/22.
//

import Foundation
import Combine

class NetworkManager: ObservableObject {
    
    static let shared = NetworkManager()
    
    let apiKey = Constants.OMDBAPI
    
    @Published var movies = [Movie]()
    @Published var totalResult = 0
    @Published var currentPage = 0
    
    func getMovies(searchTerm: String, page: Int) {
        let safeSearchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: "https://www.omdbapi.com/?apikey=\(apiKey)&s=\(safeSearchTerm)&page=\(String(page))") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let apiResponse = try decoder.decode(APIResponse.self, from: safeData)
                            DispatchQueue.main.async {
                                self.movies = apiResponse.Search
                                self.totalResult = Int(apiResponse.totalResults) ?? 0
                                self.currentPage = page
                            }
                            
                        } catch {
                            print (error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    // MARK: Fake Endpoint
    func fakeGetMovies(searchTerm: String, page: Int) {
        if let url = Bundle.main.url(forResource: "sampleResponse", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(APIResponse.self, from: data  )
                    DispatchQueue.main.async {
                        self.movies = response.Search
                        self.totalResult = Int(response.totalResults) ?? 0
                        self.currentPage = page
                    }
                } catch {
                    print("error:\(error)")
                }
            }
    }
}
