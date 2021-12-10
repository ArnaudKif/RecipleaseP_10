//
//  AlamofireRequestService.swift
//  Reciplease_P_10
//
//  Created by arnaud kiefer on 22/11/2021.
//

import Foundation
import Alamofire

class AlamoRequest {

    // MARK: - Pattern Singleton
    public static let alamoRequest = AlamoRequest()

    public init(session: AlamoSession = SearchSession()) {
        self.session = session
    }

    // MARK: - Methods
    private let session: AlamoSession

    // Set a notification when the recipe are loaded
    static let notificationRecipeLoaded = Notification.Name("recipeLoaded")
    
    // To get the data from the request
    var recipe : RecipesResult? {
        didSet {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: AlamoRequest.notificationRecipeLoaded, object: nil, userInfo: nil)
            }
        }
    }

    // MARK: - Methods
    // Create an URL with ingredients
    func searchRecipeURL(ingredient: String) -> URL {
        var getUrl = URL(string: "https://www.apple.com")!
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.edamam.com"
        urlComponents.path = "/api/recipes/v2"
        urlComponents.queryItems = [
            URLQueryItem(name: "type", value: "public"),
            URLQueryItem(name: "q", value: "\(ingredient)"),
            URLQueryItem(name: "app_id", value: "\(appId)"),
            URLQueryItem(name: "app_key", value: "\(apiKey)")]
        if let url = urlComponents.url {
            getUrl = url
        }
        print(getUrl)
        return getUrl
    }

    // Load the request
    func getRequest(ingredient: String, callback: @escaping(_ result: DataResponse<RecipesResult, AFError>?) -> Void) {
        let url = searchRecipeURL(ingredient: ingredient)
        session.request(with: url) { result in
            callback(result)
        }
    }

}
