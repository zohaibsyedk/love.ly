//
//  SettingsView.swift
//  love.ly
//
//  Created by Zohaib Syed on 12/18/25.
//

import SwiftUI
internal import Combine


struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    @State private var hideTabBar: Bool = false

    var body: some View {
        NavigationStack {
            List {
                Button("Log Out") {
                    Task {
                        do {
                            try viewModel.signOut()
                            showSignInView = true
                        } catch{
                            print(error)
                        }
                    }
                };
                Button("Toggle Tab Bar") {
                    hideTabBar.toggle()
                }
            }
            .navigationTitle("Settings")
        }
        .hideFloatingBar(hideTabBar)
    }
}

#Preview {
    SettingsView(showSignInView: .constant(false))
}
