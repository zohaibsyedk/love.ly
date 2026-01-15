//
//  ButtonWhiteStyle.swift
//  love.ly
//
//  Created by Zohaib Syed on 1/13/26.
//

import SwiftUI

struct ButtonBlackStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("Lexend-Bold", size: 18))
            .foregroundColor(Color(hex: "2b2626"))
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.white)
            .cornerRadius(30)
            .shadow(
                color: .black.opacity(configuration.isPressed ? 0.05 : 0.1),
                radius: configuration.isPressed ? 2 : 5,
                x: 0,
                y: configuration.isPressed ? 2 : 5
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
}
