//
//  MovieItemView.swift
//  Movie Time
//
//  Created by Ming Liang Khong on 24/6/22.
//

import SwiftUI

struct MovieItemView: View {
    let width: Double
    var body: some View {
        ZStack (alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 5.0).stroke()
            Text("Avengers Endgame")
                .padding(2.0)
                .background(
                    RoundedRectangle(cornerRadius: 5.0)
                        .foregroundColor(
                            Color.gray.opacity(0.5)
                        )
                )
        }
        .frame(width: width * 0.9, height: width *  1.35)
    }
}

struct MovieItemView_Previews: PreviewProvider {
    static var previews: some View {
        MovieItemView(width: 100.0)
    }
}
