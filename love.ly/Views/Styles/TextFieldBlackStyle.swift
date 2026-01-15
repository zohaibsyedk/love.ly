//
//  ButtonWhiteStyle.swift
//  love.ly
//
//  Created by Zohaib Syed on 1/13/26.
//

import SwiftUI

struct TextFieldBlackStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .font(.custom("Lexend-Bold", size: 18))
            .padding(.horizontal, 15)
            .foregroundColor(Color.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color(hex: "2B2626"))
            .cornerRadius(30)
            .shadow(
                color: .black.opacity(0.1),
                radius: 5,
                x: 0,
                y: 5
            )
            .scaleEffect(1.0)
    }
}
