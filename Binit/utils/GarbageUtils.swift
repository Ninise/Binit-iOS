//
//  GarbageTypeUtils.swift
//  Binit
//
//  Created by Nikita on 27.09.2023.
//

import Foundation

class GarbageUtils {
    
    static let GARBAGE_TYPE = "Garbage"
    static let HHW_TYPE = "HHW"
    static let ORGANIC_TYPE = "Organic"
    static let RECYCLE_TYPE = "Recycle"
    static let OVERSIZE_TYPE = "Oversize"
    static let ELECTRONIC_WASTE_TYPE = "Electronic Waste"
    static let NOT_ACCEPTED_TYPE = "Not Accepted"
    static let DEPOT_TYPE = "Depot"
    static let YARD_WASTE_TYPE = "Yard Waste"
    static let METAL_ITEMS_TYPE = "Metal Items"
    
    
    class func getBinByType(type: String) -> String {
        switch type {
        case GARBAGE_TYPE: return "ic_main_garbage"
        case RECYCLE_TYPE: return "ic_main_recycle"
        case ORGANIC_TYPE: return "ic_main_organic"
        case ELECTRONIC_WASTE_TYPE: return "ic_main_e_waste"
        case HHW_TYPE: return "ic_main_house_hazard"
        case YARD_WASTE_TYPE: return "ic_main_yard_waste"
            
        default:
            return "ic_main_garbage"
        }
    }
    
    class func getIconByTypee(type: String) -> String {
        switch type {
        case GARBAGE_TYPE: return "ic_garbage"
        case RECYCLE_TYPE: return "ic_recycle"
        case ORGANIC_TYPE: return "ic_organic"
        case ELECTRONIC_WASTE_TYPE: return "ic_e_waste"
        case HHW_TYPE: return "ic_hazard"
        case YARD_WASTE_TYPE: return "ic_house"
            
        default:
            return "ic_garbage"
        }
    }
    
}
