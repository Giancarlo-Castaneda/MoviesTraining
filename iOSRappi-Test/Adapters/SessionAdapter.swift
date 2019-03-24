//
//  SessionAdapter.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/18/19.
//  Copyright © 2019 GianC. All rights reserved.
//

import Alamofire

// Class used to handle cache policy
class SessionAdapter: RequestAdapter {
    
    private let cachePolicy: URLRequest.CachePolicy
    
    init(cachePolicy: URLRequest.CachePolicy) {
        self.cachePolicy = cachePolicy
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(root_url) {
            
            switch AppDelegate.shared.connectionStatus {
            
            case .notReachable, .unknown:
                urlRequest.cachePolicy = self.cachePolicy
            
            default:
                break
            }
        }
        return urlRequest
    }
}
