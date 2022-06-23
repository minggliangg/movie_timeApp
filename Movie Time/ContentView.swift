//
//  ContentView.swift
//  Movie Time
//
//  Created by Ming Liang Khong on 23/6/22.
//

import SwiftUI

struct ContentView: View {
    @State var textInput = ""
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack (alignment: .center) {
                    Text("🎬").font(.system(size:32.0)).padding()
                    TextField( "Search", text: $textInput)
                        .padding(4.0)
                        .overlay(RoundedRectangle(cornerRadius: 5.0).stroke())
                        .padding()
                    Button(action: {
                        print(textInput)
                        hideKeyboard()
                    }) {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .font(.system(size: 32.0))
                    }
                    .padding()
                }
                .background(
                    Color
                        .white
                        .ignoresSafeArea()
                        .shadow(color: .gray, radius: 5, x: 4.0, y: 4.0)
                )
                MovieScrollView(columnWidth: geometry.size.width / 2 * 0.8)
            }
        }
       
      
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MovieScrollView: View {
    let columnWidth: Double
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: columnWidth))]) {
                ForEach(0 ..< 30) { item in
                    ZStack (alignment: .bottomLeading) {
                        RoundedRectangle(cornerRadius: 5.0).stroke()
                        Text("Avengers Endgame")
                            .padding(2.0)
                            .background(
                                RoundedRectangle(cornerRadius: 5.0)
                                    .foregroundColor(Color.gray.opacity(0.5)
                                                    )
                            )
                    }
                    .frame(width: columnWidth * 0.9, height: columnWidth *  1.35)
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

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
