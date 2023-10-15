//
//  DropReceivableObservableObject.swift
//  Binit
//
//  Created by Nikita on 15.10.2023.
//

import SwiftUI

public protocol DropReceivableObservableObject: ObservableObject {
    associatedtype DropReceivable: DropReceiver
    
    func setDropArea(_ dropArea: CGRect, on dropReceiver: DropReceivable)
}


