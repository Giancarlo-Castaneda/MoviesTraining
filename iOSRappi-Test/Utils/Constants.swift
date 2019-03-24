//
//  Constants.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/18/19.
//  Copyright © 2019 GianC. All rights reserved.
//

// This file contains the constants used to call the services.

import Foundation

enum apiVersion
{
    case three
    case four
}

extension apiVersion
{   
    var number : String{
        switch self {
        case .three: return "3"
        case .four: return "4"
        }
    }
    
    var key : String{
        switch self {
        case .three: return "e2c11c9b86cb2ae8bd6a0726aa097d6d"
        case .four: return "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMmMxMWM5Yjg2Y2IyYWU4YmQ2YTA3MjZhYTA5N2Q2ZCIsInN1YiI6IjVjOTA2NjA0YzNhMzY4NjExNjRmZjc0ZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Ap3xhafAHd6Jy2og7SO2Wo9TeFvj0h7Slw09N10B9jQ"
        }
    }
}

    private let server = "https://api.themoviedb.org/"

    let imagesUrl = "https://image.tmdb.org/t/p/"

    let kYTembed = "https://www.youtube.com/embed/"

    let root_url = server+apiVersion.three.number+"/"
    

