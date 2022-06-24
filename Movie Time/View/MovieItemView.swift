//
//  MovieItemView.swift
//  Movie Time
//
//  Created by Ming Liang Khong on 24/6/22.
//

import SwiftUI

struct MovieItemView: View {
    let title: String
    let imageUrl: String
    let width: Double
    var body: some View {
        ZStack (alignment: .bottomLeading) {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image.resizable().aspectRatio(2 / 3 ,contentMode: .fill).frame(width: width,height: 1.5 * width)
            } placeholder: {
                RoundedRectangle(cornerRadius: 5.0).frame(width: width,height: 1.5 * width)
            }
            .aspectRatio(contentMode: .fill)
            .clipShape(RoundedRectangle(cornerRadius: 5.0))
            Text(title)
                .foregroundColor(.white)
                .padding(2.0)
                .background(
                    RoundedRectangle(cornerRadius: 5.0)
                        .foregroundColor(
                            Color.gray.opacity(0.5)
                        )
                )
        }
    }
}

struct MovieItemView_Previews: PreviewProvider {
    static var previews: some View {
        MovieItemView(title: "Marvel",imageUrl: "https://m.media-amazon.com/images/M/MV5BMTE0YWFmOTMtYTU2ZS00ZTIxLWE3OTEtYTNiYzBkZjViZThiXkEyXkFqcGdeQXVyODMzMzQ4OTI@._V1_SX300.jpg", width: 100)
    }
}
