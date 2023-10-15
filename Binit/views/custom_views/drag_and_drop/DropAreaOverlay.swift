//
//  DropAreaOverlay.swift
//  Binit
//
//  Created by Nikita on 15.10.2023.
//

import SwiftUI

struct DropAreaOverlay<T: DropReceivableObservableObject>: ViewModifier {
    @EnvironmentObject var model: T
    let dropReceiver: T.DropReceivable
    
    public func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geo in
                    Color.clear
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                model.setDropArea(geo.frame(in: .global), on: dropReceiver)
                            })
                        }
                        #if os(iOS)
                        .onRotate { _ in
                            model.setDropArea(geo.frame(in: .global), on: dropReceiver)
                        }
                        #endif
                }
            )
    }
}

extension View {
    public func dropReceiver<T: DropReceivableObservableObject>(for dropReceiver: T.DropReceivable, model: T) -> some View {
        modifier(DropAreaOverlay<T>(dropReceiver: dropReceiver))
            .environmentObject(model)
    }
}
