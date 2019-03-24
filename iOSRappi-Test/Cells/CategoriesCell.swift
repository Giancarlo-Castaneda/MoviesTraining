//
//  CategoriesCell.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/19/19.
//  Copyright © 2019 GianC. All rights reserved.
//

import UIKit

class CategoriesCell: UICollectionViewCell {
    
    static let identifier = "CategoriesCell"
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var selectedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectedView.customLayer(cornerRadius: self.selectedView.bounds.height/2)
    }
    
    func assignCategories(category : FilterData)
    {
        self.selectedView.isHidden = !(category.status ?? false)
        self.categoryLabel.text = category.categoryCase?.title
    }
    
}
