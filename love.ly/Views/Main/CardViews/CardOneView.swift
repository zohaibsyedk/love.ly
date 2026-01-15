//
//  CardOneView.swift
//  love.ly
//
//  Created by Zohaib Syed on 1/13/26.
//

import SwiftUI
internal import Combine
import FirebaseAuth

struct CardOneView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // 1. Header Section: Icon and Title
            HStack(spacing: 15) {
                // The blank white square (placeholder for app icon)
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .frame(width: 70, height: 70)
                
                Text("Send Your Love")
                    .font(.system(size: 30, weight: .regular))
                    .foregroundColor(.white)
                
                Spacer() // Pushes content to the left
            }
            .padding(.top, 10)
            
            // 2. The Button
            Button(action: {
                print("done")
            }) {
                Text("purchase product")
                    .font(.body)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity) // Makes button span width
                    .padding(.vertical, 16)
                    .background(Color(red: 0.5, green: 0.7, blue: 1.0)) // Light Blue
                    .cornerRadius(25)
            }
            
            // 3. Body Text
            // Using a text block that repeats to match the visual density of the imag
            
        }
        .padding(30) // Internal padding for the card content
        .background(Color(red: 0.22, green: 0.3, blue: 0.65)) // Deep Royal Blue Background
        .cornerRadius(40)
        // The following padding ensures the card sits nicely on the phone screen
        .padding(.horizontal)
    }
}

struct CardOneView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray.opacity(0.2).ignoresSafeArea() // Light gray background for contrast
            ScrollView {
                CardOneView()
            }
        }
    }
}
