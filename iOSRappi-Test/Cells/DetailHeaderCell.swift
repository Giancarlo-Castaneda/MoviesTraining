//
//  DetailHeaderCell.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/23/19.
//  Copyright © 2019 GianC. All rights reserved.
//

import UIKit

class DetailHeaderCell: UITableViewCell {

    static let identifier = "DetailHeaderCell"
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var companiesLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.mainImage.customLayer(cornerRadius: 5)
        self.containerView.customLayer(cornerRadius: 5)
        self.containerView.dropShadow(color: .black, opacity: 0.2, offSet: CGSize(width: 1, height: 2), radius: 10)
        self.imageContainer.customLayer(cornerRadius: 5)
        self.imageContainer.dropShadow(color: .black, opacity: 0.4, offSet: CGSize(width: 1, height: 2), radius: 10)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func assignDetailInfo(data:Results)
    {
        let url = imagesUrl+"w400"+(data.poster_path ?? "")
        self.mainImage.sd_setImage(with: URL(string: url), placeholderImage: nil)
        self.mainImage.sd_setShowActivityIndicatorView(true)
        self.mainImage.sd_setIndicatorStyle(.gray)
        
        var _production_companies = ""
        
        _ = data.production_companies.map({ (d1) in
            let name = d1.name ?? ""
            _production_companies = _production_companies + name + ", "
        })
        
        self.titleLabel.text = data.title
        self.statusLabel.text = data.status
        self.releaseDateLabel.text = "releaseDate".localizedUsingDetailFile()+(data.release_date ?? "")
        self.runtimeLabel.text = "duration".localizedUsingDetailFile()+" \(data.runtime ?? 0)"+"min".localizedUsingDetailFile()
        self.voteCountLabel.text = "\(data.vote_count ?? 0)"+"votes".localizedUsingDetailFile()
        self.voteAverageLabel.text = "voteAverague".localizedUsingDetailFile()+"\(data.vote_average ?? 0)"
        self.companiesLabel.text = "productionCompanies".localizedUsingDetailFile()+_production_companies
        self.overviewLabel.text = "synopsis".localizedUsingDetailFile()+(data.overview ?? "-")
    }

}
