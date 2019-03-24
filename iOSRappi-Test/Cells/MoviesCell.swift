//
//  MoviesCell.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/19/19.
//  Copyright © 2019 GianC. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesCell: UICollectionViewCell {
    
    static let identifier = "MoviesCell"
    @IBOutlet weak var posterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.posterImage.clipsToBounds = true
        self.posterImage.customLayer(cornerRadius: 5)
    }
    
    func assignMovies(data:Results)
    {
        let url = imagesUrl+"w400"+(data.poster_path ?? "")
        self.posterImage.sd_setImage(with: URL(string: url), placeholderImage: nil)
    }
}
