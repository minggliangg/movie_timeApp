//
//  ApiService.swift
//  Movie Time
//
//  Created by Ming Liang Khong on 24/6/22.
//

import Foundation
import Combine

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let apiKey = Constants.OMDBAPI
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    let decoder = JSONDecoder()
    
    func getMovies(searchTerm: String, page: Int) async -> MovieScrollModel? {
        let safeSearchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=\(apiKey)&s=\(safeSearchTerm)&page=\(String(page + 1))&type=movie") else { fatalError("Invalid Url.")}
        
        let urlRequest = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            let result = try decoder.decode(APIResponse.self, from: data )
            return MovieScrollModel(movies: result.Search, totalResult: Int(result.totalResults) ?? 0, currentPage: page + 1)
        } catch is DecodingError {
            return MovieScrollModel(movies: [], totalResult:  0, currentPage: 0, noResult: true)
        } catch {
            print (error)
        }
        return nil
    }
}
