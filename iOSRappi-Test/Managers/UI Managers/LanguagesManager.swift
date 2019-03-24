//
//  LanguagesManager.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/24/19.
//  Copyright © 2019 GianC. All rights reserved.
//

import UIKit

// This class controls the configuration to show the Languages View.
open class LanguagesManager {
    
    var lanView : LanguagesView?
    
    public static let shared = LanguagesManager()
    
    func showView(view: UIView)
    {
        
        let views = Bundle.main.loadNibNamed("LanguagesView", owner: nil, options: nil)
        lanView = views?[0] as? LanguagesView
        lanView?.alpha = 0
        
        lanView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height)
        view.addSubview(lanView!)
        view.bringSubviewToFront(lanView!)
        
        lanView?.configureLanguagesView()
        
        self.lanView?.containerView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.lanView?.alpha = 1
            self.lanView?.containerView.transform = CGAffineTransform.identity
        })
        
    }
    
}
