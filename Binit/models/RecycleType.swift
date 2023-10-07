//
//  RecycleType.swift
//  Binit
//
//  Created by Nikita on 06.10.2023.
//

import Foundation

enum RecycleType {
    case RECYCLE, GARBAGE, ORGANIC, E_WASTE, HAZARD, YARD;

    
    func parseValue(value: String) -> RecycleType {
        
        switch value {
            
        case "recycle": return .RECYCLE
        case "garbage": return .GARBAGE
        case "organic": return .ORGANIC
        case "e-waste": return .E_WASTE
        case "hazard": return .HAZARD
        case "yard": return .YARD
        default:
            return .HAZARD
        }
    }
    


}
