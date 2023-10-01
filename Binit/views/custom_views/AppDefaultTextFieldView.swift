//
//  AppDefaultTextFieldView.swift
//  Binit
//
//  Created by Nikita on 01.10.2023.
//

import SwiftUI

struct AppDefaultTextFieldView: View {
    
    @Binding var text: String
    let hint: String
    let lineLimit: Int
    
    var body: some View {
        HStack {
            TextField(hint, text: $text, axis: .vertical)
                .foregroundColor(.mainColor)
                .tint(.orangeColor)
                .accentColor(.gray)
                .lineLimit(lineLimit, reservesSpace: true)
                .padding(.horizontal, 8)
                .padding(.vertical, 10)
        }
        .background(Color.searchBodyColor.opacity(0.1))
        .cornerRadius(6)
        .padding(.horizontal, 5)
    }
}
