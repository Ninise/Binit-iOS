//
//  AppSettings.swift
//  Binit
//
//  Created by Nikita on 21.10.2023.
//

import Foundation

class AppSettings {
    
    let SHOW_DND_GAME_RULES = "SHOW_DND_GAME_RULES"
    let SHOW_INITIAL_DIALOG = "SHOW_INITIAL_DIALOG"
    
    static let shared = AppSettings()
    
    private init() {}
    
    func setValue(flag: Bool, key: String) {
        UserDefaults.standard.set(flag, forKey: key)
    }
    
    func setUserSawDndRules(flag: Bool) {
        setValue(flag: flag, key: SHOW_DND_GAME_RULES)
    }
    
    func isUserSawDndRules() -> Bool {
        return UserDefaults.standard.bool(forKey: SHOW_DND_GAME_RULES)
    }
        
    func setInitialDialogShown(flag: Bool) {
        setValue(flag: flag, key: SHOW_INITIAL_DIALOG)
    }
    
    func isShownInitialDialog() -> Bool {
        return UserDefaults.standard.bool(forKey: SHOW_INITIAL_DIALOG)
    }
    
}
