import SwiftUI

struct NewAuthView2: View {
    
    @Binding var showSignInView: Bool
    @State private var showEmailSignIn = false
    @Binding var curUser: DBUser
    @Binding var curGift: ProductItem
    @Binding var update: Bool
    @Binding var authUser: AuthDataResultModel?
    
    var body: some View {
        ZStack {
            PinkPurpleBackground()
            
            // 2. The Content
            VStack(spacing: 20) {
                
                Spacer()
                
                // Title
                VStack(spacing: 8) {
                    Text("Welcome to Love.ly")
                        .font(.custom("Lexend-Bold", size: 32))
                        // Fallback in case font isn't loaded
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Sign In or Sign Up to Continue")
                        .font(.custom("Lexend-Bold", size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(.white.opacity(0.9))
                }
                .padding(.bottom, 10)
                
                // Buttons
                VStack(spacing: 8) {
                    // Sign In Button
                    Button("Sign In") {
                        showEmailSignIn = true
                    }
                    .buttonStyle(ButtonWhiteStyle())
//                    NavigationLink(destination: SignInEmailView(showSignInView: $showSignInView, curUser: $curUser, curGift: $curGift, update: $update, authUser: $authUser), isActive: $showEmailSignIn) {
//                        EmptyView()
//                    }
                    
                    // Sign Up Button
                    Button("Sign Up") {
                        showEmailSignIn = true
                    }
                    .buttonStyle(ButtonWhiteStyle())
                }
                .padding(.horizontal, 40) // Controls how wide the buttons are
                
                Spacer()
            }
        }
        .onAppear {
            for family in UIFont.familyNames.sorted() {
                print("Family: \(family)")
                for name in UIFont.fontNames(forFamilyName: family) {
                    print(" \(name)")
                }
            }
        }
    }
}

// MARK: - Color Extension for Hex Support
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

//struct AuthView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewAuthView()
//    }
//}
