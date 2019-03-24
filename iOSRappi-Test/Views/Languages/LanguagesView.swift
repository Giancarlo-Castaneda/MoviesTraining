//
//  LanguagesView.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/24/19.
//  Copyright © 2019 GianC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LanguagesView: UIView {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var languagesTableView: UITableView!
    @IBOutlet weak var closeButton: UIButton!
    let disposeBag = DisposeBag()
    
    var languageSelected : ((BaseLanguage) -> Void)?
    
    func configureLanguagesView()
    {
        self.closeButton.customLayer(cornerRadius: self.closeButton.bounds.height/2)
        self.closeButton.dropShadow(color: .black, opacity: 0.2, offSet: CGSize(width: 1, height: 2), radius: 3)
        
        self.languagesTableView.register(UINib(nibName: "LanguagesCell", bundle: nil), forCellReuseIdentifier: LanguagesCell.identifier)
        self.languagesTableView.tableFooterView = UIView()
        
        RappiTestLocalization.shared.languagesObservable
            .asObservable()
            .bind(to: self.languagesTableView.rx.items(cellIdentifier: LanguagesCell.identifier,
                                                       cellType: LanguagesCell.self)) {
                                                        row, model, cell in
                                                        cell.assignLanguages(data: model)
            }
            .disposed(by: self.disposeBag)
        
        self.languagesTableView.rx
            .modelSelected(BaseLanguage.self)
            .subscribe(onNext: { (value) in
                self.hideView()
                self.languageSelected?(value)
            }).disposed(by: self.disposeBag)
    }
    
    func hideView()
    {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
            self.containerView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }, completion: { (completion) in
            self.removeFromSuperview()
        })
    }
    
    @IBAction func didPressClose(_ sender: UIButton) {
        self.hideView()
    }
    
}
