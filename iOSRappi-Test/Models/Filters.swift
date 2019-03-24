//
//  Filters.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/24/19.
//  Copyright © 2019 GianC. All rights reserved.
//

import UIKit

// This model contains the categories filter data
class FilterData {
    
    var categoryCase : categoryCase?
    var status: Bool?
    
    required init?(categoryCase: categoryCase,status:Bool) {
        self.categoryCase = categoryCase
        self.status = status
    }
}


