//
//  TabBarItem.swift
//  Binit
//
//  Created by Nikita on 26.11.2023.
//


import SwiftUI

enum TabBarItem: Hashable {
    case home, search, schedule, settings

    var iconName: String {
        switch self {
        case .home: return "ic_main_home"
        case .search: return "ic_main_search"
        case .schedule: return "ic_main_calendar"
        case .settings: return "ic_main_settings"
        }
    }
    
    var iconNameActive: String {
        switch self {
        case .home: return "ic_main_home_active"
        case .search: return "ic_main_search_active"
        case .schedule: return "ic_main_calendar_active"
        case .settings: return "ic_main_settings_active"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .search: return "Search"
        case .schedule: return "Schedule"
        case .settings: return "Settings"
        }
    }
    
    var color: Color {
        return .additionalTextColor
    }
    
    var colorSelected: Color {
        return .orangeColor
    }
    
}
