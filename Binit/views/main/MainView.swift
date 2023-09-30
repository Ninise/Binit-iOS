//
//  MainView.swift
//  Binit
//
//  Created by Nikita on 27.09.2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image("ic_main_home")
                        .resizable()
                        .scaledToFit()
                    
                    Text("Home")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
