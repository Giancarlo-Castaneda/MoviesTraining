//
//  ConnectionManager.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/18/19.
//  Copyright © 2019 GianC. All rights reserved.
//

import Alamofire

// This enum is similar to that used by the network accessibility manager
/// Used to handle network changes
enum connectionCases
{
    case unknown
    case notReachable
    case reachable
}

class ConnectionManager {
    
    static let shared = ConnectionManager()
    
    // Reachability Manager instance
    let connectionManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
    
    // Stops listening for changes in network reachability status
    func stopListener()
    {
        self.connectionManager?.stopListening()
    }
    
    // Listen to reachability status changes.
    func startListener() {
        
        // Listen reachability
        self.connectionManager?.listener = { status in
            switch status {
                
            case .notReachable:
                print("The network is not reachable")
                AppDelegate.shared.connectionStatus = .notReachable
                
            case .unknown :
                
                print("It is unknown whether the network is reachable")
                AppDelegate.shared.connectionStatus = .unknown
                
            case .reachable(.ethernetOrWiFi), .reachable(.wwan):
                print("The network is reachable over the WiFi connection")
                AppDelegate.shared.connectionStatus = .reachable
            
            }
        
            // start listening
            self.connectionManager?.startListening()
        }
    }
}
