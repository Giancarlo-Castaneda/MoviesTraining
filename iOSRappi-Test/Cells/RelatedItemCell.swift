//
//  RelatedItemCell.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/23/19.
//  Copyright © 2019 GianC. All rights reserved.
//

import UIKit
import WebKit

class RelatedItemCell: UICollectionViewCell {
    
    static let identifier = "RelatedItemCell"
    @IBOutlet weak var itemWebView: WKWebView!
    @IBOutlet weak var titleItemLabel: UILabel!
    @IBOutlet weak var webContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.itemWebView.customLayer(cornerRadius: 5)
        self.webContainer.customLayer(cornerRadius: 5)
        self.webContainer.dropShadow(color: .black, opacity: 0.7, offSet: CGSize(width: 1, height: 2), radius: 10)
    }
    
    func assignVideos(data: Results)
    {
        let urlVideo = kYTembed+(data.key ?? "")
        if let url = URL(string: urlVideo) {
            self.itemWebView.load(URLRequest(url: url))
        }
        self.titleItemLabel.text = data.name
    }
}
