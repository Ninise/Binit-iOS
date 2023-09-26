//
//  AppDefaultButton.swift
//  Binit
//
//  Created by Nikita on 25.09.2023.
//

import SwiftUI

struct AppDefaultButton: View {
    
    let title: LocalizedStringKey
    let color: Color
    let callback: () -> Void
    
    var body: some View {
        ZStack {
            Button(action: {
                callback()
            }, label: {
                Text(title)
                    .font(.custom(FontUtils.FONT_MEDIUM, size: 16))
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal, 40)
            })
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 6))
        }
    }
}
