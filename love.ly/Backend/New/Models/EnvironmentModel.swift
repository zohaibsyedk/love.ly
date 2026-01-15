
import SwiftUI
import Foundation
internal import Combine

@MainActor
class EnvironmentModel: ObservableObject {
    @AppStorage("myUser") private var myUser: Data = Data()
    @AppStorage("myGift") private var myGift: Data = Data()
    @Published var loadUser: MyUser = MyUser()
    @Published var loadGift: Gift = Gift()
    @Published var type: Int = 0
    
    init(){
        loadUser = (try? JSONDecoder().decode(MyUser.self, from: myUser)) ?? MyUser()
        loadGift = (try? JSONDecoder().decode(Gift.self, from: myGift)) ?? Gift()
    }
    
    func setUser(_ user: MyUser){
        loadUser = user
        saveUser()
    }
    
    func setGift(_ gift: Gift){
        loadGift = gift
        saveGift()
    }
    
    private func saveUser() {
        myUser = (try? JSONEncoder().encode(loadUser)) ?? Data()
    }
    
    private func saveGift() {
        myGift = (try? JSONEncoder().encode(loadGift)) ?? Data()
    }
    
}
