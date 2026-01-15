//
//  CardOneView.swift
//  love.ly
//
//  Created by Zohaib Syed on 1/13/26.
//

import SwiftUI
internal import Combine
import FirebaseAuth

struct CardOne2View: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text(String(repeating: "text text text ", count: 40))
                .font(.body)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true) // Allows text to grow vertically
            
        }
        .padding(30) // Internal padding for the card content
        .background(Color(red: 0.22, green: 0.3, blue: 0.65)) // Deep Royal Blue Background
        .cornerRadius(40)
        // The following padding ensures the card sits nicely on the phone screen
        .padding(.horizontal)
    }
}

struct CardOne2View_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray.opacity(0.2).ignoresSafeArea() // Light gray background for contrast
            ScrollView {
                CardOne2View()
            }
        }
    }
}
