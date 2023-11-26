//
//  TabView.swift
//  Binit
//
//  Created by Nikita on 26.11.2023.
//

import SwiftUI

struct TabView: View {
    
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem

    var body: some View {
        HStack (alignment: .center) {
            ForEach(tabs, id: \.self) { tab in
                Spacer()
                tabView(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
                    .padding(.horizontal, -3)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        
        
    }
}

struct TabView_Previews: PreviewProvider {
    
    static let tabs: [TabBarItem] = [
        .home, .search, .schedule, .settings
    ]
    
    static var previews: some View {
        VStack (alignment: .center, spacing: 2) {
            Spacer()
            TabView(tabs: tabs, selection: .constant(tabs.first!))
            Spacer()
        }
    }
}

extension TabView {
    private func tabView(tab: TabBarItem) -> some View {
        VStack {
            Image(selection == tab ? tab.iconNameActive : tab.iconName)
            Text(tab.title)
                .lineLimit(1)
                .font(.custom(FontUtils.FONT_REGULAR, size: 12))
                .foregroundColor(selection == tab ? tab.colorSelected : tab.color)
        }
        .padding(.top, 8)        
    }
    
    private func switchToTab(tab: TabBarItem) {
        selection = tab
    }
}


