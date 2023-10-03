//
//  AppDefaultNotButton.swift
//  Binit
//
//  Created by Nikita on 02.10.2023.
//

import SwiftUI

struct AppDefaultNotButton: View {
    
    let title: LocalizedStringKey
    let color: Color
    
    var iconRight: String? = nil
    
    var body: some View {
        HStack {
            Spacer()
            Text(title)
                .font(.custom(FontUtils.FONT_MEDIUM, size: 16))
                .foregroundColor(.white)
                .padding(.vertical)
            
            if let icon = iconRight {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(.leading, -5)
            }
            Spacer()
        }
        .frame(width: .infinity)
        .background(color)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}
