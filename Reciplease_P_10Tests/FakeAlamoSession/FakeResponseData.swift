//
//  FakeResponseData.swift
//  Reciplease_P_10Tests
//
//  Created by arnaud kiefer on 06/12/2021.
//

import Foundation
import Alamofire

class FakeResponseData {

    // MARK: - Data
    static var recipesCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "LemonRecipes", withExtension: "json")!

        return try! Data(contentsOf: url)
    }

    static let incorrectData = "error".data(using: .utf8)!

    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://www.apple.com")!,
        statusCode: 200, httpVersion: nil, headerFields: nil)!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://www.apple.com")!,
        statusCode: 500, httpVersion: nil, headerFields: nil)!

    // MARK: - Error
    static let error = AFError.explicitlyCancelled
}
