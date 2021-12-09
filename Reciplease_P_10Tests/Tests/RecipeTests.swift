//
//  RecipeTests.swift
//  Reciplease_P_10Tests
//
//  Created by arnaud kiefer on 27/11/2021.
//

import XCTest
import Alamofire
@testable import Reciplease_P_10

class RecipeTests: XCTestCase {

    // MARK: - Tests
    func testUrlCreation() {
        let urlCreated = AlamoRequest.alamoRequest.searchRecipeURL(ingredient: ingredient)
        XCTAssertEqual(url, urlCreated)
        XCTAssertNotNil(urlCreated)
    }

    func testUrlCreationFailed() {
        let urlCreated = AlamoRequest.alamoRequest.searchRecipeURL(ingredient: ingredient).deletingLastPathComponent()
        XCTAssertNotEqual(url, urlCreated)
        XCTAssertNotNil(urlCreated)
    }

    func testResponseIfAllIsSucess () {
        fakeResponseData = FakeAlamoResponse(
            data: FakeResponseData.recipesCorrectData,
            response: FakeResponseData.responseOK,
            error: nil)
        fakeAlamoRequest = AlamoRequest(session: SearchSessionFake(fakeResponse: fakeResponseData))
        let expectation = XCTestExpectation(description: "Wait for queue change")
        fakeAlamoRequest.getRequest(ingredient: "Lemon") { (result) in
            guard let recipe = result?.value else {
                XCTFail("Test with success failed")
                return  }
        expectation.fulfill()
            XCTAssertEqual(recipe.hits[0].recipe.label, "Lemon Sorbet")
            XCTAssertNil(result?.error)
        }
        wait(for: [expectation], timeout: 10)
    }

    func testResponseIfDataOK_ResponseKO_ErrorIsNil () {
        fakeResponseData = FakeAlamoResponse(
            data: FakeResponseData.recipesCorrectData,
            response: FakeResponseData.responseKO,
            error: nil)
        fakeAlamoRequest = AlamoRequest(session: SearchSessionFake(fakeResponse: fakeResponseData))
        let expectation = XCTestExpectation(description: "Wait for queue change")
        fakeAlamoRequest.getRequest(ingredient: ingredient) { result in
            guard let status = result?.response?.statusCode else {
                XCTFail("Error Status Response Test")
                return
            }
            guard let data = result?.data else {
                XCTFail("Error Data Response Test")
                return
            }
        expectation.fulfill()
            XCTAssertEqual(500, status)
            XCTAssertNotEqual(self.incorrectData, data)
            XCTAssertNil(result?.error)
        }
        wait(for: [expectation], timeout: 10)
    }

    func testResponseIfDataKO_ResponseOK_ErrorIsNil () {
        fakeResponseData = FakeAlamoResponse(
            data: FakeResponseData.incorrectData,
            response: FakeResponseData.responseOK,
            error: nil)
        fakeAlamoRequest = AlamoRequest(session: SearchSessionFake(fakeResponse: fakeResponseData))
        let expectation = XCTestExpectation(description: "Wait for queue change")
        fakeAlamoRequest.getRequest(ingredient: ingredient) { result in
            guard let status = result?.response?.statusCode else {
                XCTFail("Error Status Response Test")
                return
            }
            guard let data = result?.data else {
                XCTFail("Error Data Response Test")
                return
            }
        expectation.fulfill()
            XCTAssertEqual(self.incorrectData, data)
            XCTAssertEqual(200, status)
            XCTAssertNotNil(result?.error)
            XCTAssertEqual(result!.error!.errorDescription, self.error)
        }
        wait(for: [expectation], timeout: 10)
    }

    func testResponseIfDataOk_ResponseOK_ErrorIsNotNil () {
        fakeResponseData = FakeAlamoResponse(
            data: FakeResponseData.recipesCorrectData,
            response: FakeResponseData.responseOK,
            error: FakeResponseData.error)
        fakeAlamoRequest = AlamoRequest(session: SearchSessionFake(fakeResponse: fakeResponseData))

        let expectation = XCTestExpectation(description: "Wait for queue change")
        fakeAlamoRequest.getRequest(ingredient: ingredient) { result in
            guard let status = result?.response?.statusCode else {
                XCTFail("Error Status Response Test")
                return
            }
            guard let data = result?.data else {
                XCTFail("Error Data Response Test")
                return
            }
        expectation.fulfill()
            XCTAssertNotEqual(self.incorrectData, data)
            XCTAssertEqual(200, status)
            XCTAssertNotNil(result?.error)
            XCTAssertEqual(result!.error!.errorDescription, self.error)
        }
        wait(for: [expectation], timeout: 10)
    }

    func testUpdateRecipe() {
        let alamo = AlamoRequest.alamoRequest
        let vc = RecipesTableViewController()
        let hit0 = vc.hit?.count
        let data = FakeResponseData.recipesCorrectData
        alamo.recipe = try? JSONDecoder().decode(RecipesResult.self, from: data!)
        let hit1 = vc.hit?.count
        XCTAssertEqual(hit0, hit1)
    }

    // MARK: - Tools for test : Properties
    var fakeResponseData : FakeAlamoResponse!
    var fakeAlamoRequest: AlamoRequest!
    let url = URL(string: "https://api.edamam.com/api/recipes/v2?type=public&q=Lemon&app_id=\(appId)&app_key=\(apiKey)")
    let ingredient = "Lemon"
    let incorrectData = "error".data(using: .utf8)!
    let error = "Request explicitly cancelled."

}
