////
////  ProfileViewModel.swift
////  love.ly
////
////  Created by Zohaib Syed on 1/9/26.
////
//
//import Foundation
//internal import Combine
//
//
//@MainActor
//final class ProfileViewModel: ObservableObject {
//    
//    @Published private(set) var user: DBUser? = nil
//    @Published private var sendId: String?
//    
//    func loadCurrentUser() async throws {
//        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
//        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
//    }
//    
//}
