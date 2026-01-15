//
//  PinkPurpleBackground.swift
//  love.ly
//
//  Created by Zohaib Syed on 1/13/26.
//

import SwiftUI

struct PinkPurpleBackground: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(hex: "f5329c"),
                Color(hex: "9a13f9")
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}
