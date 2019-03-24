//
//  EmptyManager.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/24/19.
//  Copyright © 2019 GianC. All rights reserved.
//


import UIKit

// This class controls the configuration to show the empty view.
open class EmptyManager {
    
    var emptyView : EmptyView?
    
    public static let shared = EmptyManager()
    
    func showView(view: UIView)
    {
        
        let views = Bundle.main.loadNibNamed("EmptyView", owner: nil, options: nil)
        emptyView = views?[0] as? EmptyView
        emptyView?.alpha = 1
        
        emptyView?.frame = CGRect(x: 0, y: 0, width: view.bounds.width , height: view.bounds.height)
        view.addSubview(emptyView!)
        view.bringSubviewToFront(emptyView!)
        
        emptyView?.configureEmptyView()
        
    }
    
}

