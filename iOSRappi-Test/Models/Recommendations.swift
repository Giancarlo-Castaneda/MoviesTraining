//
//  Recommendations.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/23/19.
//  Copyright © 2019 GianC. All rights reserved.
//

import Foundation
import ObjectMapper

// This model contains the Recommendations data
class RecommendationsMapper:Mappable{
    
    var results: [ResultsMapper] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        results <- map["results"]
        
    }
}

class Recommendations {
    
    var results: [ResultsMapper] = []
}
