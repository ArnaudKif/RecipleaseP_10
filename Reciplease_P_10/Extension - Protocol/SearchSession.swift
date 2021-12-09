//
//  URLModel.swift
//  Reciplease_P_10
//
//  Created by arnaud kiefer on 22/11/2021.
//

import Foundation
import Alamofire

protocol AlamoSession {
    func request(with url: URL, callBack: @escaping(_ result: DataResponse<RecipesResult, AFError>?) -> Void)
}


final class SearchSession: AlamoSession {
    func request(with url: URL, callBack: @escaping(_ result: DataResponse<RecipesResult, AFError>?) -> Void) {
        AF.request(url).responseDecodable(of: RecipesResult.self) { (DataResponse) in
            callBack(DataResponse)
        }
    }
}
