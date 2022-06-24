//
//  MovieScrollView.swift
//  Movie Time
//
//  Created by Ming Liang Khong on 24/6/22.
//

import SwiftUI

struct MovieScrollView: View {
    let columnWidth: Double
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: columnWidth))]) {
                ForEach(0 ..< 30) { item in
                    MovieItemView(width: columnWidth)
                }
            }
            .padding()
            
        }.gesture(DragGesture().onChanged({ _ in
            hideKeyboard()
        }))
        .onTapGesture {
            hideKeyboard()
        }
    }
}

struct MovieScrollView_Previews: PreviewProvider {
    static var previews: some View {
        MovieScrollView(columnWidth: 100.0).previewLayout(.sizeThatFits)
    }
}

