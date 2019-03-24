//
//  DetailRelatedCell.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/23/19.
//  Copyright © 2019 GianC. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class DetailRelatedCell: UITableViewCell {
    
    static let identifier = "DetailRelatedCell"
    @IBOutlet weak var relatedLabel: UILabel!
    @IBOutlet weak var videosCollection: UICollectionView!
    var videosData = BehaviorRelay<[Results]>(value: [])
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        self.videosData.asObservable()
            .bind(to: self.videosCollection.rx.items(cellIdentifier: RelatedItemCell.identifier,
                                                     cellType:  RelatedItemCell.self)){
                                                        item, model, cell in
                                                        cell.assignVideos(data: model)
        }.disposed(by: self.disposeBag)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func assignRelatedVideos(data: [Results])
    {
        self.videosData.accept(data)
    }

}
