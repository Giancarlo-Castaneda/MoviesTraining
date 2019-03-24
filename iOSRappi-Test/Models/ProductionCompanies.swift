//
//  ProductionCompanies.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/23/19.
//  Copyright © 2019 GianC. All rights reserved.
//

import Foundation
import ObjectMapper

// This model contains the Production Companies data
class ProductionCompaniesMapper:Mappable{
    
    var name: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        
    }
}

class ProductionCompanies {
    
    var name: String?
}
