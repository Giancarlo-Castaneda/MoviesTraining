//
//  HomeViewController.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/19/19.
//  Copyright © 2019 GianC. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!{
        didSet {
            categoriesCollectionView.delegate = nil
            categoriesCollectionView.dataSource = nil
        }
    }
    @IBOutlet weak var moviesCollectionView: UICollectionView!{
        didSet {
            moviesCollectionView.delegate = nil
            moviesCollectionView.dataSource = nil
        }
    }
    
    let disposeBag = DisposeBag()
    let movieViewModel = MovieViewModel()
    var page = 1
    var categorySelected : categoryCase = .popular
    let categoriesFilter = BehaviorRelay<[FilterData]>(value: [FilterData.init(categoryCase: categoryCase.popular, status: true)!,
                                                               FilterData.init(categoryCase: categoryCase.topRated, status: false)!,
                                                               FilterData.init(categoryCase: categoryCase.upComing, status: false)!])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerView.dropShadow(color: .black, opacity: 0.4, offSet: CGSize(width: 1, height: 2), radius: 3)
        
        self.setCategories()
        self.setMovies()
        self.configureEmptyHome()
        self.getCategoriesInfo(catCase: self.categorySelected,page: 1)
        self.changeLanguageImage(language: RappiTestLocalization.shared.baseLanguage)
        
    }
    
    //MARK: - Empty Home Response.
    func configureEmptyHome()
    {
        self.movieViewModel.emptyHome.asDriver()
            .drive(onNext: { (value) in
                
                if value
                {
                    EmptyManager.shared.showView(view: self.view)
                    self.view.bringSubviewToFront(self.headerView)
                }
                else {  EmptyManager.shared.emptyView?.removeFromSuperview() }
                
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: self.disposeBag)
    }
    
    //MARK: - Assign current language image.
    private func changeLanguageImage(language : BaseLanguage)
    {
        self.languageButton.setImage(language.image, for: .normal)
        self.languageButton.setImage(language.image, for: .selected)
    }
    
    //MARK: - Handling of web service calls.
    func getCategoriesInfo(catCase: categoryCase,page: Int)
    {
        self.movieViewModel.getMovieCategorie(category: catCase, page: page)
    }
    
    //MARK: -  Paging control to call the web service.
    func nextPage()
    {
        self.page += 1
        guard self.page <= self.movieViewModel.resultsData.value.first?.total_pages ?? 1 else
        {
            return
        }
        
        self.getCategoriesInfo(catCase: self.categorySelected,page: self.page)
    }

    //MARK: - Move moviesCollectionView to top
    func moveCollectionToTop()
    {
        var inset = CGPoint.zero
        inset.y -= self.moviesCollectionView.contentInset.top
        
        self.moviesCollectionView.setContentOffset(inset, animated: true)
    }
    
    
    //MARK: - Configure moviesCollectionView
    func setMovies()
    {
        
        // Assign delegate using RxSwift
        self.moviesCollectionView.rx
            .setDelegate(self)
            .disposed(by: self.disposeBag)
        
        // Bind data to collectionView
        self.movieViewModel.resultsData
            .asObservable()
            .bind(to: self.moviesCollectionView.rx.items(cellIdentifier: MoviesCell.identifier,
                                                         cellType: MoviesCell.self)){
                                                            item, model, cell in
                                                            cell.assignMovies(data: model)
            }.disposed(by: self.disposeBag)
        
        // Collection view model selected
        self.moviesCollectionView.rx
            .modelSelected(Results.self)
            .subscribe(onNext: { (model) in
                
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                vc.movieId = model.id ?? 0
                self.navigationController?.pushViewController(vc, animated: true)
                
            }, onError: { (error) in
                print(error.localizedDescription)
            }, onCompleted: {
                print("Completed")
            }) {
                print("Disposed")
            }.disposed(by: self.disposeBag)
        
        
        // Manage contentOffset to call paging method
        self.moviesCollectionView.rx.contentOffset
            .asObservable()
            .subscribe(onNext: { (offset) in
                
                let visibleHeight = self.moviesCollectionView.frame.height - self.moviesCollectionView.contentInset.top - self.moviesCollectionView.contentInset.bottom
                let y = offset.y + self.moviesCollectionView.contentInset.top
                let threshold = max(0.0, self.moviesCollectionView.contentSize.height - visibleHeight)
                y > threshold ? self.nextPage() : ()
                
            }, onError: { (error) in
                print(error.localizedDescription)
            }, onCompleted: {
                print("Completed")
            }) {
                print("Disposed")
            }.disposed(by: self.disposeBag)
    }
    
    //MARK: - Configure categoriesCollectionView
    func setCategories()
    {
        // Assign delegate using RxSwift
        self.categoriesCollectionView.rx
            .setDelegate(self)
            .disposed(by: self.disposeBag)
        
        // Bind categories data to categoriesCollectionView using RxSwift
        self.categoriesFilter
            .asObservable()
            .bind(to: self.categoriesCollectionView.rx.items(cellIdentifier: CategoriesCell.identifier,
                                                             cellType: CategoriesCell.self)){
                                                                row, model, cell in
                                                                
                                                                cell.assignCategories(category: model)
        }.disposed(by:  self.disposeBag)
        
        // Collection view item selected
        self.categoriesCollectionView.rx
            .itemSelected
            .map { index in
                return (index, self.categoriesFilter.value[index.row])
            }
            .subscribe(onNext: { index, model in
                
                self.moveCollectionToTop()
                
                let currenteFilter = model.categoryCase ?? .popular
                
                guard self.categorySelected != currenteFilter else
                {
                    return
                }
                
                for i in 0...self.categoriesFilter.value.count - 1
                {
                    self.categoriesFilter.value[i].status = false
                }
                self.categoriesFilter.value[index.row].status = true
                self.categoriesCollectionView.reloadData()
                
                self.categorySelected = currenteFilter
                self.page = 1
                self.movieViewModel.pageMovies.removeAll()
                self.getCategoriesInfo(catCase: currenteFilter, page: self.page)
                
            }, onError: { (error) in
                print(error.localizedDescription)
            }, onCompleted: {
                print("Completed")
            }) {
                print("Disposed")
            }.disposed(by: self.disposeBag)
    }
    
    @IBAction func didPressLanguage(_ sender: UIButton) {
        
        LanguagesManager.shared.lanView?.removeFromSuperview()
        LanguagesManager.shared.showView(view: self.view)
        
        LanguagesManager.shared.lanView?.languageSelected = {
            (option: BaseLanguage) -> Void in
            
            guard RappiTestLocalization.shared.baseLanguage != option else
            {
                return
            }
            
            self.changeLanguageImage(language: option)
            RappiTestLocalization.shared.baseLanguage = option
            self.categoriesCollectionView.reloadData()
            self.page = 1
            self.movieViewModel.pageMovies.removeAll()
            self.getCategoriesInfo(catCase: self.categorySelected,page: 1)
            
        }
    }
    

}

extension HomeViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let customWidth = collectionView.bounds.width / 3 - 5
        
        guard collectionView != self.categoriesCollectionView else
        {
            return CGSize(width: customWidth, height: collectionView.bounds.height)
        }
        
        return CGSize(width: customWidth, height: customWidth+(customWidth*0.4))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(5)
    }
}
