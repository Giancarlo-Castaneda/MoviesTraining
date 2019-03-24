//
//  DetailRecommendedCell.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/23/19.
//  Copyright © 2019 GianC. All rights reserved.
//

import UIKit
import SDWebImage

class DetailRecommendedCell: UITableViewCell {

    static let identifier = "DetailRecommendedCell"
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieContainer: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        self.containerView.customLayer(cornerRadius: 5)
        self.containerView.dropShadow(color: .black, opacity: 0.2, offSet: CGSize(width: 1, height: 1), radius: 10)
        
        self.movieImage.customLayer(cornerRadius: 5)
        self.movieContainer.customLayer(cornerRadius: 5)
        self.movieContainer.dropShadow(color: .black, opacity: 0.4, offSet: CGSize(width: 1, height: 2), radius: 10)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func assignSearchResults(data: OnlineSearchViewModel)
    {
        let url = imagesUrl+"w400"+(data.searchResult.poster_path ?? "")
        
        self.movieImage.sd_setImage(with: URL(string: url), placeholderImage: nil)
        self.averageLabel.text = "voteAverague".localizedUsingDetailFile()+"\(data.searchResult.vote_average ?? 0)"
        self.votesLabel.text = "\(data.searchResult.vote_count ?? 0)"+"votes".localizedUsingDetailFile()
        self.titleLabel.text = data.searchResult.title
    }
    
    func assignRecommendations(data: Results)
    {
        let url = imagesUrl+"w400"+(data.poster_path ?? "")
        
        self.movieImage.sd_setImage(with: URL(string: url), placeholderImage: nil)
        self.overviewLabel.text = "synopsis".localizedUsingDetailFile()+(data.overview ?? "")
        self.averageLabel.text = "voteAverague".localizedUsingDetailFile()+"\(data.vote_average ?? 0)"
        self.votesLabel.text = "\(data.vote_count ?? 0)"+"votes".localizedUsingDetailFile()
        self.titleLabel.text = data.title
    }

}
