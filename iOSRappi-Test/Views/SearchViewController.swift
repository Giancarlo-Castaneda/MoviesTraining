//
//  SearchViewController.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/24/19.
//  Copyright © 2019 GianC. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import IQKeyboardManagerSwift

class SearchViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTableView: UITableView!
        {
        didSet {
            searchTableView.delegate = nil
            searchTableView.dataSource = nil
        }
    }
    
    let disposeBag = DisposeBag()
    let movieManager = MovieDBManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTextField.becomeFirstResponder()
        self.searchTextField.placeholder = "search".localizedUsingGeneralFile()
        self.headerView.dropShadow(color: .black, opacity: 0.4, offSet: CGSize(width: 1, height: 2), radius: 3)
        self.searchTextField.dropShadow(color: .black, opacity: 0.4, offSet: CGSize(width: 1, height: 2), radius: 3)
        self.configureSearcher()
        // Do any additional setup after loading the view.
    }
    
    func configureSearcher()
    {
        self.searchTableView.tableFooterView = UIView()
        self.searchTableView.separatorStyle = .none
        
        _ = searchTextField.rx.text.orEmpty
            .asDriver()
            .drive(onNext: { (value) in
                _ = value != "" && IQKeyboardManager.shared.keyboardShowing
                    ? self.activityIndicator.startAnimating()
                    : self.activityIndicator.stopAnimating()
                
            }, onCompleted: nil, onDisposed: nil)
        
        
        let results = searchTextField.rx.text.orEmpty
            
            .asDriver()
            .throttle(0.3)
            .distinctUntilChanged()
            .flatMapLatest { query in
                
                self.movieManager.searchMovie(query: query)
                    
                    .retry(3)
                    .asDriver(onErrorJustReturn: [])
            }
            .map { results in
                results.map(OnlineSearchViewModel.init)
        }
        
        results
            .drive(self.searchTableView.rx.items(cellIdentifier: DetailRecommendedCell.identifier,
                                                 cellType: DetailRecommendedCell.self)){
                                                    row, model, cell in
                                                    cell.assignSearchResults(data: model)
            }
            .disposed(by: self.disposeBag)
        
        results
            .drive(onNext: { _ in
                
                self.activityIndicator.stopAnimating()
                
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: self.disposeBag)
        
        results
            .map { $0.count == 0 || $0.isEmpty == true}
            .drive(self.searchTableView.rx.isHidden)
            .disposed(by: self.disposeBag)
        
        
        // SearchTableView item selected
        self.searchTableView.rx
            .modelSelected(OnlineSearchViewModel.self)
            .asDriver()
            .drive(onNext: { searchResult in
                
                
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                    vc.movieId = searchResult.searchResult.id ?? 0
                    self.navigationController?.pushViewController(vc, animated: true)
                
                
            })
            .disposed(by: self.disposeBag)
    
    }

}
