//
//  SearchViewModel.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/24/19.
//  Copyright © 2019 GianC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// Search view model
class OnlineSearchViewModel {
    
    let searchResult: ResultsMapper
    
    init(searchResult: ResultsMapper) {
        self.searchResult = searchResult
    }
    
}
