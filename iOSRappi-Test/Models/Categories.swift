//
//  Categories.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/18/19.
//  Copyright © 2019 GianC. All rights reserved.
//

import Foundation
import ObjectMapper

enum categoryCase {
    case popular
    case topRated
    case upComing
}

extension categoryCase
{
    var tag : String {
        switch self {
        case .popular: return "popular"
        case .topRated: return "top_rated"
        case .upComing: return "upcoming"
        }
    }
    
    var title : String {
        switch self {
        case .popular: return "popular".localizedUsingGeneralFile()
        case .topRated: return "topRated".localizedUsingGeneralFile()
        case .upComing: return "upcoming".localizedUsingGeneralFile()
        }
    }
}

// This model contains the getCategories data
class CategoriesMapper: Mappable {
    
    var total_pages: Int?
    var results:[ResultsMapper] = []
    var page : Int?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        
        total_pages <- map["total_pages"]
        results <- map["results"]

    }
    
}

class Categories{
    
    var total_pages: Int?
    var results:[ResultsMapper] = []
    var page : Int?
}
