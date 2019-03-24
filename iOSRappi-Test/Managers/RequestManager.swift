//
//  RequestManager.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/18/19.
//  Copyright © 2019 GianC. All rights reserved.
//

import Alamofire

//Class to configure the requests to web services with alamofire
class RequestManager {
    
    static let shared = RequestManager()
    
    let sessionManager: Alamofire.SessionManager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "190.131.203.107": .disableEvaluation
        ]
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        
        if #available(iOS 11.0, *) {
            configuration.waitsForConnectivity = true
        } else {
            // Fallback on earlier versions
        }
        
        return Alamofire.SessionManager(
            configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
    }()
}
