//
//  Results.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/23/19.
//  Copyright © 2019 GianC. All rights reserved.
//

import Foundation
import ObjectMapper

// This model contains the Results data
class ResultsMapper: Mappable {
    
    var total_pages: Int?
    var id: Int?
    var original_language: String?
    var title: String?
    var overview: String?
    var popularity: String?
    var poster_path: String?
    var release_date: String?
    var vote_average:Double?
    var vote_count:Int?
    var runtime:Int?
    var production_companies: [ProductionCompaniesMapper] = []
    var adult: Bool?
    var status: String?
    var videos : VideosMapper?
    var recommendations: RecommendationsMapper?
    var relatedType : relatedType?
    
    var key : String?
    var name : String?
    var type : String?
    
    required init(map: Map) {
        
    }
    func mapping(map: Map) {
        
        id <- map["id"]
        original_language <- map["original_language"]
        title <- map["title"]
        overview <- map["overview"]
        popularity <- map["popularity"]
        poster_path <- map["poster_path"]
        release_date <- map["release_date"]
        vote_average <- map["vote_average"]
        vote_count <- map["vote_count"]
        runtime <- map["runtime"]
        production_companies <- map["production_companies"]
        adult <- map["adult"]
        status <- map["status"]
        videos <- map["videos"]
        recommendations <- map["recommendations"]
        
        key <- map["key"]
        name <- map["name"]
        type <- map["type"]
    }
    
}

class Results{
    var total_pages: Int?
    var id: Int?
    var original_language: String?
    var title: String?
    var overview: String?
    var popularity: String?
    var poster_path: String?
    var release_date: String?
    var vote_average:Double?
    var vote_count:Int?
    var runtime:Int?
    var production_companies: [ProductionCompaniesMapper] = []
    var adult: Bool?
    var status: String?
    var videos : VideosMapper?
    var recommendations: RecommendationsMapper?
    var relatedType : relatedType?
    
    var key : String?
    var name : String?
    var type : String?
    
}
