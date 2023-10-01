//
//  View+extensions.swift
//  Binit
//
//  Created by Nikita on 01.10.2023.
//

import Foundation
import SwiftUI

extension View {
    func placeholder(
        _ text: LocalizedStringKey,
        when shouldShow: Bool,
        alignment: Alignment = .leading) -> some View {
                
            Text(text)
                    .font(.custom(FontUtils.FONT_REGULAR, size: 12))
                .foregroundColor(.gray) 
    }
}
