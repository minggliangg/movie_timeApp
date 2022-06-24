//
//  View+extensions.swift
//  Movie Time
//
//  Created by Ming Liang Khong on 24/6/22.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
