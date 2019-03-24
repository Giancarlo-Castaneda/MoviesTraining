//
//  MovieViewModel.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/19/19.
//  Copyright © 2019 GianC. All rights reserved.
//

// This class contains data management and its transfer to the observables used.

import Foundation
import RxCocoa
import RxSwift

enum relatedType {
    case relatedVideo
    case recommended
    case detail
}

class MovieViewModel {
    
    let movieManager = MovieDBManager()
    
    var pageCategories = BehaviorRelay<[Categories]>(value: [])
    
    var pageMovies : [Results] = []
    var pageMoviesRelay = BehaviorRelay<[Results]>(value: [])
    
    var resultsData = BehaviorRelay<[Results]>(value: [])
    var emptyHome = BehaviorRelay<Bool>(value: false)
    
    
    var relatedVideos = BehaviorRelay<[Results]>(value: [])
    
    var detailData = BehaviorRelay<[Results]>(value: [])
    var related : [Results] = []
    var recommendedInfo = BehaviorRelay<[Results]>(value: [])
    var emptyDetail = BehaviorRelay<Bool>(value: false)
    
    let disposeBag = DisposeBag()
    
    /**
        This function controls the existing information by adding the data of the following pages of the web service
     */
    func getMovieCategorie(category:categoryCase, page: Int ) {
        
        self.movieManager.getCategories(category: category, page: page).subscribe(onNext: { (data) in
            
            DispatchQueue.main.async() {
                
                self.pageCategories.accept(data.map{ s1 -> Categories in
                    let movie = Categories()
                    movie.results = s1.results
                    movie.total_pages = s1.total_pages
                    
                    return movie })
                
                let catResults = self.pageCategories.value.first?.results ?? []
                
                self.pageMoviesRelay.accept(catResults.map{ s1 -> Results in
                    
                    let results = Results()
                    results.id = s1.id
                    results.title = s1.title
                    results.overview = s1.overview
                    results.poster_path = s1.poster_path
                    results.release_date = s1.release_date
                    results.total_pages = self.pageCategories.value.first?.total_pages ?? 1
                        
                    return results })
                
                self.pageMovies.append(contentsOf: self.pageMoviesRelay.value)
                self.resultsData.accept(self.pageMovies)
                
                // Variable used to manage home empty data
                self.emptyHome.accept(self.resultsData.value.isEmpty)
            }
            
        }, onError: { error in
            print(error.localizedDescription)
        },
           onCompleted: {
            print("Completed")
        },
           onDisposed: {
            print("Disposed")
        }).disposed(by: self.disposeBag)
        
    }
    
    /**
        Detail view controller is built with a table and three different cells, this function manages the data obtained from the service to order them at convenience to be displayed in the different cells
     */
    func getDetailInfo(movie_id:Int)
    {
        self.movieManager.getDetail(movieId: movie_id).subscribe(onNext: { data in
            
            DispatchQueue.main.async {
                
                // Filling the variable used to show the data of detail
                self.detailData.accept(data.map({ (s1) -> Results in
                    
                    let results = Results()
                    results.id = s1.id
                    results.title = s1.title
                    results.overview = s1.overview
                    results.poster_path = s1.poster_path
                    results.release_date = s1.release_date
                    results.runtime = s1.runtime
                    results.adult = s1.adult
                    results.status = s1.status
                    results.vote_count = s1.vote_count
                    results.vote_average = s1.vote_average
                    results.videos = s1.videos
                    results.recommendations = s1.recommendations
                    results.production_companies = s1.production_companies
                    results.key = s1.key
                    results.name = s1.name
                    results.type = s1.type
                    results.relatedType = relatedType.detail
                    
                    return results
                    
                }))
                
                self.related.removeAll() //Cleaning temp
                
                // Adding item that represents detail header
                if !self.detailData.value.isEmpty
                {
                    let mainResult = Results()
                    self.related.append(mainResult)
                }
                
                // Temp variable that contains related videos
                let kVideos = self.detailData.value.first?.videos?.results ?? []
                
                // Filling the variable used to show the data of related videos
                self.relatedVideos.accept(kVideos.map({ (s2) -> Results in
                    let results = Results()
                    results.key = s2.key
                    results.name = s2.name
                    results.type = s2.type
                    results.relatedType = relatedType.relatedVideo
                    
                    return results
                }))
                
                // Adding item that represents related videos
                if !kVideos.isEmpty
                {
                    let additionalResult = Results()
                    self.related.append(additionalResult)
                }
                
                
                // Temp variable that contains related videos
                let kRecomended = self.detailData.value.first?.recommendations?.results ?? []
                
                // Adding items that represents recommendations
                self.related.append(contentsOf: kRecomended.map({ (s3) -> Results in
                    let results = Results()
                    results.id = s3.id
                    results.title = s3.title
                    results.overview = s3.overview
                    results.poster_path = s3.poster_path
                    results.vote_average = s3.vote_average
                    results.vote_count = s3.vote_count
                    results.relatedType = relatedType.recommended
                    
                    return results
                }))
                
                self.recommendedInfo.accept(self.related)
                
                // Variable used to manage detail empty data
                self.emptyDetail.accept(self.recommendedInfo.value.isEmpty)
                
            }
            
        }, onError: { error in
            print(error.localizedDescription)
        },
           onCompleted: {
            print("Completed")
        },
           onDisposed: {
            print("Disposed")
        }).disposed(by: self.disposeBag)
    }
}
