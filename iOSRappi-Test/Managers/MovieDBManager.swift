//
//  MovieDBManager.swift
//  iOSRappi-Test
//
//  Created by Giancarlo Castañeda Garcia on 3/19/19.
//  Copyright © 2019 GianC. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import RxSwift

// This class contains web service calls
class MovieDBManager  {
    
    //MARK: - Get a list of movies by category.
    func getCategories(category:categoryCase, page: Int) -> Observable<[CategoriesMapper]> {
        
        return Observable<[CategoriesMapper]>.create { observer in
            
            let parameters = [
                "language":RappiTestLocalization.shared.baseLanguage.tag,
                "page":"\(page)",
                "api_key":apiVersion.three.key
            ]
            
            let request = RequestManager.shared.sessionManager.request("\(root_url)movie/\(category.tag)?".addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!, method: .get,parameters:parameters)
            
            
            request.validate()
                .responseObject { (response: DataResponse<CategoriesMapper>) in
                    
                    guard let value = response.result.value else {
                        let emptyResponse = [CategoriesMapper]()
                        observer.onNext(emptyResponse)
                        observer.onCompleted()
                        
                        return
                    }
                    observer.onNext([value])
                    observer.onCompleted()
                    
                }
                
                .responseJSON { response in
                    
                    print("Result:movie \(response.result)")
                    guard let json = response.result.value else {
                        print("error",response.error ?? "")
                        return
                    }
                    print("JSON: \(json)") // serialized json response
            }
            
            return Disposables.create {
                request.cancel()
            }
            
        }
        
    }
    
    //MARK: - Get the detail of the selected movie with its related videos and recommended movies.
    func getDetail(movieId:Int) -> Observable<[ResultsMapper]> {
        
        return Observable<[ResultsMapper]>.create { observer in
            
            let parameters = [
                "api_key":apiVersion.three.key,
                "language":RappiTestLocalization.shared.baseLanguage.tag,
                "append_to_response":"videos,recommendations"
            ]
            let request = RequestManager.shared.sessionManager.request("\(root_url)movie/\(movieId)?".addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!, method: .get,parameters:parameters)
            
            request.validate()
                .responseObject { (response: DataResponse<ResultsMapper>) in
                    
                    guard let value = response.result.value else {
                        
                        let dict : Dictionary<String, Any> = ["":""]
                        
                        let map : Map =  Map(mappingType: MappingType.fromJSON, JSON: dict, toObject: true, context: nil, shouldIncludeNilValues: true)
                        
                        let emptyResults = ResultsMapper.init(map: map)
                        observer.onNext([emptyResults])
                        observer.onCompleted()
                        
                        return
                    }
                    observer.onNext([value])
                    observer.onCompleted()
                    
                }
                
                .responseJSON { response in
                    
                    print("Result: \(response.result)")
                    guard let json = response.result.value else {
                        print("error",response.error ?? "")
                        return
                    }
                    print("JSON: \(json)") // serialized json response
            }
            
            return Disposables.create {
                request.cancel()
            }
            
        }
        
    }
    
    //MARK: - Obtain a list of movies according to the user's search.
    func searchMovie(query:String) -> Observable<[ResultsMapper]> {
        
        return Observable<[ResultsMapper]>.create { observer in
            
            let parameters = [
                "api_key":apiVersion.three.key,
                "language":RappiTestLocalization.shared.baseLanguage.tag,
                "query":query
            ]
            let request = RequestManager.shared.sessionManager.request("\(root_url)search/movie?".addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!, method: .get,parameters:parameters)
            
            request.validate()
                .responseArray(keyPath: "results") { (response: DataResponse<[ResultsMapper]>) in
                    
                    guard let value = response.result.value else {
                        let emptyService = [ResultsMapper]()
                        observer.onNext(emptyService)
                        observer.onCompleted()
                        
                        return
                    }
                    observer.onNext(value)
                    observer.onCompleted()
                    
                }
                
                .responseJSON { response in
                    
                    print("Result:search \(response.result)")
                    guard let json = response.result.value else {
                        print("error",response.error ?? "")
                        return
                    }
                    print("JSON: \(json)") // serialized json response
            }
            
            return Disposables.create {
                request.cancel()
            }
            
        }
        
    }
}
