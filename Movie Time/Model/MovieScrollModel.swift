//
//  MovieScrollModel.swift
//  Movie Time
//
//  Created by Ming Liang Khong on 24/6/22.
//

import Foundation

struct MovieScrollModel {
    let movies: [Movie]
    let totalResult: Int
    let currentPage: Int
    var noResult: Bool = false
}
