//
//  View+extension.swift
//  Binit
//
//  Created by Nikita on 21.10.2023.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func onNotification(
        _ notificationName: Notification.Name,
        perform action: @escaping () -> Void
    ) -> some View {
        onReceive(NotificationCenter.default.publisher(
            for: notificationName
        )) { _ in
            action()
        }
    }
    
    func onNotification(
        _ notificationName: Notification.Name,
        perform action: @escaping (NotificationCenter.Publisher.Output) -> Void
    ) -> some View {
        onReceive(NotificationCenter.default.publisher(
            for: notificationName
        )) { data in
            action(data)
        }
    }
}

