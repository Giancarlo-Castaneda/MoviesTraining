//
//  DetailViewController.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/23/19.
//  Copyright © 2019 GianC. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.delegate = nil
            tableView.dataSource = nil
        }
    }
    
    var movieId = 0
    let disposeBag = DisposeBag()
    let movieViewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getDetailContent()
        self.setRelatedInfo()
        self.configureEmptyDetail()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Empty Detail Response.
    func configureEmptyDetail()
    {
        self.movieViewModel.emptyDetail.asDriver()
            .drive(onNext: { (value) in
                
                _ = value
                    ? EmptyManager.shared.showView(view: self.view)
                    : EmptyManager.shared.emptyView?.removeFromSuperview()
                
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: self.disposeBag)
    }
    
    //MARK: - Configure detail tableView
    func setRelatedInfo()
    {
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        
        // Bind data to tableView using different cells
        self.movieViewModel.recommendedInfo.asObservable()
            .bind(to: self.tableView.rx.items) { (tableView, row, element) in
                let indexPath = IndexPath(row: row, section: 0)
               
                let headerCell = tableView.dequeueReusableCell(withIdentifier: DetailHeaderCell.identifier, for: indexPath) as! DetailHeaderCell
                let relatedCell = tableView.dequeueReusableCell(withIdentifier: DetailRelatedCell.identifier, for: indexPath) as! DetailRelatedCell
                let recommendedCell = tableView.dequeueReusableCell(withIdentifier: DetailRecommendedCell.identifier, for: indexPath) as! DetailRecommendedCell
                
                let kRelatedVideos = self.movieViewModel.relatedVideos.value

                if row == 0
                {
                    headerCell.assignDetailInfo(data: self.movieViewModel.detailData.value.first ?? Results())
                    return headerCell
                }
                else if row == 1 && kRelatedVideos.isEmpty != true
                {
                    relatedCell.assignRelatedVideos(data: kRelatedVideos)
                    return relatedCell
                }
                else
                {
                    recommendedCell.assignRecommendations(data: element)
                    return recommendedCell
                }
                
        }.disposed(by: self.disposeBag)
        
        // Table view model selected
        self.tableView.rx
            .modelSelected(Results.self)
            .subscribe(onNext: { (model) in
                
                if model.relatedType == relatedType.recommended
                {
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                    vc.movieId = model.id ?? 0
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }, onError: { (error) in
                print(error.localizedDescription)
            }, onCompleted: {
                print("Completed")
            }) {
                print("Disposed")
            }.disposed(by: self.disposeBag)
    }
    
    
    //MARK: - Detail web service call.
    func getDetailContent()
    {
        self.movieViewModel.getDetailInfo(movie_id: self.movieId)
    }

}
