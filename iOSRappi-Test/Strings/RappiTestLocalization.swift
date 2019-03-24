//
//  RappiTestLocalization.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/24/19.
//  Copyright © 2019 GianC. All rights reserved.
//

import UIKit
import RxCocoa

// This class contains the data related to language that will have the app

/**
 type of language that will have the app, if it will support more languages, please added here, as a case, to select the correct localization file
 
 - EN:     English
 - ES:     Español
 */
enum BaseLanguage: String {
    /// English
    case EN = "en"
    /// Spanish
    case ES = "es"
}

extension BaseLanguage{
    
    var tag : String{
        switch self {
        case .ES: return "es-CO"
        case .EN: return "en-US"
        }
    }
    
    var title : String{
        switch self {
        case .ES: return "spanish".localizedUsingGeneralFile()
        case .EN: return "english".localizedUsingGeneralFile()
        }
    }
    
    var image : UIImage{
        switch self {
        case .ES: return UIImage(named: "spanish-language") ?? UIImage.init()
        case .EN: return UIImage(named: "english-language") ?? UIImage.init()
        }
    }
}



/**
 * class to handle the base language
 */
class RappiTestLocalization {
    
    fileprivate init() {}
    
    var languagesObservable = BehaviorRelay<[BaseLanguage]>(value: [BaseLanguage.EN,BaseLanguage.ES])
    
    /// base language, its gonna say what language its be used, by default, the system language
    var baseLanguage: BaseLanguage = .ES
    
    /// Singleton instance to easy access through classes
    static let shared = RappiTestLocalization()
}
