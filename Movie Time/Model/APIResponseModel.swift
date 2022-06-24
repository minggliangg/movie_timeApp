//
//  MovieEntry.swift
//  Movie Time
//
//  Created by Ming Liang Khong on 24/6/22.
//

import Foundation
import SwiftUI

struct APIResponse: Decodable {
    let Search: [Movie]
    let totalResults: String
    let Response: String
}

struct Movie: Decodable, Identifiable {
    var id: String {
        return imdbID
    }
    let Title: String
    let Year: String
    let imdbID: String
    let `Type`: String
    let Poster: String
}
