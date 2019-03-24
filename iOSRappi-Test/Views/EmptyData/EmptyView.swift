//
//  EmptyView.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/24/19.
//  Copyright © 2019 GianC. All rights reserved.
//

import UIKit

class EmptyView: UIView {

    @IBOutlet weak var messageLabel: UILabel!
    
    func configureEmptyView()
    {
        self.messageLabel.text = "empty".localizedUsingGeneralFile()
    }

}
