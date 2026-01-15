//
//  ButtonWhiteStyle.swift
//  love.ly
//
//  Created by Zohaib Syed on 1/13/26.
//

import SwiftUI

struct SmallButtonWhiteStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("Lexend-Bold", size: 10))
            .foregroundColor(Color(hex: "9a13f9"))
            .frame(width: 50, height: 50)
            .background(Color.white)
            .clipShape(Circle())
            .shadow(
                color: .black.opacity(configuration.isPressed ? 0.05 : 0.1),
                radius: configuration.isPressed ? 2 : 5,
                x: 0,
                y: configuration.isPressed ? 2 : 5
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
}
