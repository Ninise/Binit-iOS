//
//  TabBarContainerView.swift
//  Binit
//
//  Created by Nikita on 26.11.2023.
//

import SwiftUI

struct TabBarContainerView<Content:View>: View {
    
    @Binding var selection: TabBarItem
    let content: Content
    
    @State private var tabs: [TabBarItem] = []
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        NavigationView {
            
            mainView()
                .ignoresSafeArea(.keyboard)
                .onPreferenceChange(TabBarItemsPreferenceKey.self, perform: { value in
                    self.tabs = value
                })
            
        }
    }
    
    func mainView() -> some View {
        VStack(spacing: 0) {
            ZStack {
                content
            }
            
            VStack {
                Divider()
                    .background(Color.searchTextColor.opacity(0.1))
                    .padding(.horizontal, -10)
                TabView(tabs: tabs, selection: $selection)
            }
            .padding(6)
            .background(.white)
            .padding(.top, -10)
            .padding(.bottom, -10)
        }
        
    }
}

struct TabBarContainerView_Previews: PreviewProvider {
    
    static let tabs: [TabBarItem] = [
        .home, .search
    ]
    
    static var previews: some View {
        TabBarContainerView(selection: .constant(tabs.first!)) {
            Color.pink
        }
    }
}

