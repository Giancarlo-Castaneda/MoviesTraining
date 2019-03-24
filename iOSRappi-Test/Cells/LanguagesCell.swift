//
//  LanguagesCell.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/24/19.
//  Copyright © 2019 GianC. All rights reserved.
//

import UIKit

class LanguagesCell: UITableViewCell {

    static let identifier = "LanguagesCell"
    
    @IBOutlet weak var languageImage: UIImageView!
    @IBOutlet weak var languageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.languageImage.dropShadow(color: .black, opacity: 0.2, offSet: CGSize(width: 1, height: 2), radius: 3)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func assignLanguages(data : BaseLanguage)
    {
        self.languageImage.image = data.image
        self.languageLabel.text = data.title
    }
    
}
