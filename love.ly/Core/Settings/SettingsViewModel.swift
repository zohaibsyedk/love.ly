//
//  SettingsViewModel.swift
//  love.ly
//
//  Created by Zohaib Syed on 12/21/25.
//

import Foundation
internal import Combine

@MainActor
final class SettingsViewModel: ObservableObject {
    
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
        
    }
    
}
