//
//  MainView.swift
//  Binit
//
//  Created by Nikita on 27.09.2023.
//

import SwiftUI

struct MainView: View {
    
    @State private var homeSelected: Bool = true
    @State private var collectionSelected: Bool = false
    @State private var dropOffSelected: Bool = false
    @State private var settingsSelected: Bool = false
    
    let homeSelectedIcon = "ic_main_home_active"
    let homeIcon = "ic_main_home"
    
    let calendarSelectedIcon = "ic_main_calendar_active"
    let calendarIcon = "ic_main_calendar"
    
    let locationSelectedIcon = "ic_main_location_active"
    let locationIcon = "ic_main_location"
    
    let settingsSelectedIcon = "ic_main_settings_active"
    let settingsIcon = "ic_main_settings"
    
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    TabItem(
                        icon: homeIcon,
                        text: LocalizedStringKey("Home").stringValue())
                }
            
            CollectionScheduleView()
                .tabItem {
                    TabItem(
                        icon: calendarIcon,
                        text: LocalizedStringKey("Schedule").stringValue()
                    )
                }
            
            DropOffLocationsView()
                .tabItem {
                    TabItem(
                        icon: locationIcon,
                        text: LocalizedStringKey("Locations").stringValue()
                    )
                }
            
            SettingsView()
                .tabItem {
                    TabItem(
                        icon: settingsIcon,
                        text: LocalizedStringKey("Settings").stringValue()
                    )
                }
        }
        .navigationBarBackButtonHidden()
        .tint(.orangeColor)
        .preferredColorScheme(.light)

    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct TabItem: View {
        
    let icon: String
    let text: String
    
    var body: some View {
        VStack {
            Image(icon)
                .resizable()
                .scaledToFit()
            
            Text(text)
                .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                .foregroundColor(.mainColor)
        }
    }
    
}
