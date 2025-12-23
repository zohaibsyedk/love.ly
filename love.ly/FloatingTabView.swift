//
//  FloatingTabView.swift
//  love.ly
//
//  Created by Zohaib Syed on 12/21/25.
//

import SwiftUI
internal import Combine

protocol FloatingTabProtocol {
    var symbolImage: String { get }
}

class FloatingTabViewHelper: ObservableObject {
    @Published var hideTabBar: Bool = false
}

fileprivate struct HideFloatingTabBarModifier: ViewModifier {
    var status: Bool
    @EnvironmentObject private var helper: FloatingTabViewHelper
    func body(content: Content) -> some View {
        content
            .onChange(of: status, initial: true) { oldValue, newValue in
                helper.hideTabBar = newValue
            }
    }
}

extension View {
    func hideFloatingBar(_ status: Bool) -> some View {
        self
            .modifier(HideFloatingTabBarModifier(status:status))
    }
}

struct FloatingTabView<Content: View, Value: CaseIterable & Hashable & FloatingTabProtocol>: View where Value.AllCases: RandomAccessCollection {
    var config: FloatingTabConfig
    @Binding var selection: Value
    var content: (Value, CGFloat) -> Content
    
    init(config: FloatingTabConfig = .init(), selection: Binding<Value>, @ViewBuilder content: @escaping (Value, CGFloat) -> Content) {
        self.config = config
        self._selection = selection
        self.content = content
    
    }
    
    @State private var tabBarSize: CGSize = .zero
    @StateObject private var helper: FloatingTabViewHelper = .init()
    
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if #available(iOS 18, *) {
                /// New Tab View
                TabView(selection: $selection) {
                    ForEach(Value.allCases, id: \.hashValue) { tab in
                        Tab.init(value: tab) {
                            content(tab, tabBarSize.height)
                            ///Hiding Native Tab Bar
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                    }
                }
            } else {
                /// Old Tab Layout
                TabView(selection: $selection) {
                    ForEach(Value.allCases, id: \.hashValue) { tab in
                        content(tab, tabBarSize.height)
                        ///Hiding Native Tab Bar
                            .tag(tab)
                            .toolbar(.hidden, for: .tabBar)
                    }
                }
            }
            
            FloatingTabBar(config: config, activeTab: $selection)
                .padding(.horizontal, config.hPadding)
                .padding(.bottom, config.bPadding)
                .onGeometryChange(for: CGSize.self) {
                    $0.size
                } action: { newValue in
                    tabBarSize = newValue
                }
                .offset(y: helper.hideTabBar ? (tabBarSize.height + 100) : 0)
                .animation(config.tabAnimation, value: helper.hideTabBar)
        }
        .environmentObject(helper)
    }
}

struct FloatingTabConfig {
    var activeTint: Color = .white
    var activeBackgroundTint: Color = .blue
    var inactiveTint: Color = .gray
    var tabAnimation: Animation = .smooth(duration: 0.35, extraBounce: 0)
    var backgroundColor: Color = .gray.opacity(0.1)
    var insetAmount: CGFloat = 6
    var isTranslucent: Bool = true
    var hPadding: CGFloat = 15
    var bPadding: CGFloat = 5
}

fileprivate struct FloatingTabBar<Value: CaseIterable & Hashable & FloatingTabProtocol>: View where Value.AllCases: RandomAccessCollection {
    var config: FloatingTabConfig
    @Binding var activeTab: Value
    /// For Tab Sliding Effect
    @Namespace private var animation
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Value.allCases, id: \.hashValue) { tab in
                let isActive = activeTab == tab
                
                Image(systemName: tab.symbolImage)
                    .font(.title3)
                    .foregroundStyle(isActive ? config.activeTint : config.inactiveTint)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(.rect)
                    .background {
                        if isActive {
                            Capsule(style: .continuous)
                                .fill(config.activeBackgroundTint.gradient)
                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                        }
                    }
                    .onTapGesture {
                        activeTab = tab
                    }
                    .padding(.vertical, config.insetAmount)
                
            }
        }
        .padding(.horizontal, config.insetAmount)
        .frame(height: 50)
        .background {
            ZStack {
                if config.isTranslucent {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                } else {
                    Rectangle()
                        .fill(.background)
                }
                
                Rectangle()
                    .fill(config.backgroundColor)
            }
        }
        .clipShape(.capsule(style: .continuous))
        .animation(config.tabAnimation, value: activeTab)
    }
    
}
