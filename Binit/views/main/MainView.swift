//
//  MainView.swift
//  Binit
//
//  Created by Nikita on 27.09.2023.
//

import SwiftUI

struct MainView: View {
    
    @State private var tabSelection: TabBarItem = .home
    
    @State private var searchText: String = ""
    
    
    let homeSelectedIcon = "ic_main_home_active"
    let homeIcon = "ic_main_home"
    
    let calendarSelectedIcon = "ic_main_calendar_active"
    let calendarIcon = "ic_main_calendar"
    
    let searchSelectedIcon = "ic_main_location_active"
    let searchIcon = "ic_main_search"
    
    let settingsSelectedIcon = "ic_main_settings_active"
    let settingsIcon = "ic_main_settings"
    
    
    var body: some View {
        
        NavigationStack {
            TabBarContainerView(selection: $tabSelection) {
                HomeView(onEvent: { type, obj in
                    switch type {
                    case .search:
                        tabSelection = .search
                        searchText = obj as! String
                    }
                
                })
                .tabBarItem(tab: .home, selection: $tabSelection)
                
                SearchListView(searchWord: searchText)
                    .tabBarItem(tab: .search, selection: $tabSelection)
                
                CollectionScheduleView()
                    .tabBarItem(tab: .schedule, selection: $tabSelection)
                
                SettingsView()
                    .tabBarItem(tab: .settings, selection: $tabSelection)
                
            }
        }
        .navigationBarBackButtonHidden()
        .preferredColorScheme(.light)
        

    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
