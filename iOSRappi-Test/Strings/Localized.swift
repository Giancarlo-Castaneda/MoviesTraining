//
//  Localized.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/24/19.
//  Copyright © 2019 GianC. All rights reserved.
//


// This String extension contains the logic related to language that will have the app
import Foundation

extension String {
    
    /**
     Gets the localized string from the specified strings file using the receiver as the key
     
     - parameter fileName: .strings file that contains the key
     */
    public func localized(usingFile fileName: String) -> String {
        
        return localized(usingFile: fileName,bundleLanguage: RappiTestLocalization.shared.baseLanguage.rawValue, withComment: "")
    }
    
    /**
     Gets the localized string from General file using the receiver as the key
     */
    
    public func localizedUsingGeneralFile() -> String {
        
        return localized(usingFile: "General")
    }
    
    /**
     Gets the localized string from Detail file using the receiver as the key
     */
    
    public func localizedUsingDetailFile() -> String {
        
        return localized(usingFile: "Detail")
    }
    
    
    
    /**
     Gets the localized string from the specified strings file using the receiver as the key
     - parameter fileName: .strings file that contains the key
     - parameter BundleLanguage: the base language raw value of the enum BaseLanguage
     - parameter withComment: comment
     */
    public func localized(usingFile fileName: String, bundleLanguage: String? = nil, withComment comment: String) -> String {
        
        if let bundleLanguage = bundleLanguage,
            let path = Bundle.main.path(forResource: bundleLanguage, ofType: "lproj"),
            let bundle = Bundle(path: path) {
            
            return NSLocalizedString(self, tableName: fileName, bundle: bundle, value: "", comment: comment)
            
        } else {
            return NSLocalizedString(self, tableName: fileName, bundle: Bundle.main, value: "", comment: comment)
        }
    }
}
