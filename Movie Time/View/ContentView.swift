//
//  ContentView.swift
//  Movie Time
//
//  Created by Ming Liang Khong on 23/6/22.
//

import SwiftUI

struct ContentView: View {
    init() {
        let uiNavigationBarAppearance = UINavigationBarAppearance()
        uiNavigationBarAppearance.backgroundColor = UIColor(Color.white)
        UINavigationBar.appearance().standardAppearance = uiNavigationBarAppearance
        UINavigationBar.appearance().compactAppearance = uiNavigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = uiNavigationBarAppearance
    }
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                MovieScrollView(columnWidth: geometry.size.width / 2 * 0.9)
            }.navigationTitle("Movie Time 🎬")
        }
        .navigationViewStyle(.stack)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().previewDevice(PreviewDevice(rawValue: "iPhone SE (1st generation)"))
            ContentView().previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
        }
        
    }
}



