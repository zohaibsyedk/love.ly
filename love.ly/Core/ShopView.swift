//
//  ShopView.swift
//  love.ly
//
//  Created by Zohaib Syed on 12/21/25.
//

import SwiftUI
internal import Combine

final class ShopViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
}

struct ShopView: View {
    
    @State private var productHolder: Bool = false
    @State private var showSetupView: Bool = false
    @StateObject private var viewModel = ShopViewModel()
    var body: some View {
        VStack {
            if !productHolder {
                Button("Purchase Product") {
                    Task {
                        do {
                            try await UserManager.shared.buyProduct(userId: viewModel.user!.userId)
                            productHolder = true
                        } catch {
                            // Handle error as appropriate, or ignore
                            print("Failed to buy product: \(error)")
                        }
                        }
                    }
            } else {
                Button("Product Setup"){
                    showSetupView = true
                }
                }
            
        }
        .task {
            try? await viewModel.loadCurrentUser()
            productHolder = viewModel.user?.productHolder ?? false
        }
        .fullScreenCover(isPresented: $showSetupView) {
            NavigationStack {
                SetupView()
            }
        }
    }
}

#Preview {
    ShopView()
}
