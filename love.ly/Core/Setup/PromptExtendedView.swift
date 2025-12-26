//
//  SetupView.swift
//  love.ly
//
//  Created by Zohaib Syed on 12/21/25.
//

import SwiftUI
internal import Combine



struct PersonalityPromptView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var productSetupManager: ProductSetupManager
    @State var count : Int = 0
    @Binding var navPath: [Int]
    let prompt = "personality"
    let dismissFullScreen: DismissAction
    var body: some View {
        VStack {
            PromptView(productSetupManager: productSetupManager, navPath: $navPath, dismissFullScreen: dismissFullScreen, prompt: prompt, ind: 1)
        }

    }
    
}

struct AppearencePromptView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var productSetupManager: ProductSetupManager
    @State var count : Int = 0
    @Binding var navPath: [Int]
    let prompt = "appearence"
    let dismissFullScreen: DismissAction
    var body: some View {
        VStack {
            PromptView(productSetupManager: productSetupManager, navPath: $navPath, dismissFullScreen: dismissFullScreen, prompt: prompt, ind: 2)
        }

    }
    
}

struct InsecurityPromptView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var productSetupManager: ProductSetupManager
    @State var count : Int = 0
    @Binding var navPath: [Int]
    let prompt = "insecurity"
    let dismissFullScreen: DismissAction
    var body: some View {
        VStack {
            PromptView(productSetupManager: productSetupManager, navPath: $navPath, dismissFullScreen: dismissFullScreen, prompt: prompt, ind: 3)
        }

    }
    
}

struct HardshipPromptView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var productSetupManager: ProductSetupManager
    @State var count : Int = 0
    @Binding var navPath: [Int]
    let prompt = "hardship"
    let dismissFullScreen: DismissAction
    var body: some View {
        VStack {
            PromptView(productSetupManager: productSetupManager, navPath: $navPath, dismissFullScreen: dismissFullScreen, prompt: prompt, ind: 4)
        }

    }
    
}

struct DreamsPromptView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var productSetupManager: ProductSetupManager
    @State var count : Int = 0
    @Binding var navPath: [Int]
    let prompt = "dreams"
    let dismissFullScreen: DismissAction
    var body: some View {
        VStack {
            PromptView(productSetupManager: productSetupManager, navPath: $navPath, dismissFullScreen: dismissFullScreen, prompt: prompt, ind: 5)
        }

    }
    
}

struct SmallThingsPromptView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var productSetupManager: ProductSetupManager
    @State var count : Int = 0
    @Binding var navPath: [Int]
    let prompt = "smallthings"
    let dismissFullScreen: DismissAction
    var body: some View {
        VStack {
            PromptView(productSetupManager: productSetupManager, navPath: $navPath, dismissFullScreen: dismissFullScreen, prompt: prompt, ind: 6)
        }

    }
    
}

struct SongsPromptView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var productSetupManager: ProductSetupManager
    @State var count : Int = 0
    @Binding var navPath: [Int]
    let prompt = "Songs"
    let dismissFullScreen: DismissAction
    var body: some View {
        VStack {
            PromptView(productSetupManager: productSetupManager, navPath: $navPath, dismissFullScreen: dismissFullScreen, prompt: prompt, ind: 7)
        }

    }
    
}

struct FuturePromptView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var productSetupManager: ProductSetupManager
    @State var count : Int = 0
    @Binding var navPath: [Int]
    let prompt = "future"
    let dismissFullScreen: DismissAction
    var body: some View {
        VStack {
            PromptView(productSetupManager: productSetupManager, navPath: $navPath, dismissFullScreen: dismissFullScreen, prompt: prompt, ind: 8)
        }

    }
    
}

struct TalentsPromptView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var productSetupManager: ProductSetupManager
    @State var count : Int = 0
    @Binding var navPath: [Int]
    let prompt = "talents"
    let dismissFullScreen: DismissAction
    var body: some View {
        VStack {
            PromptView(productSetupManager: productSetupManager, navPath: $navPath, dismissFullScreen: dismissFullScreen, prompt: prompt, ind: 9)
        }

    }
    
}

struct OtherPromptView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var productSetupManager: ProductSetupManager
    @State var count : Int = 0
    @Binding var navPath: [Int]
    let prompt = "other"
    let dismissFullScreen: DismissAction
    var body: some View {
        VStack {
            PromptView(productSetupManager: productSetupManager, navPath: $navPath, dismissFullScreen: dismissFullScreen, prompt: prompt, ind: 10)
        }

    }
    
}
