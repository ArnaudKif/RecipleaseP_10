//
//  SearchServiceTest.swift
//  Reciplease_P_10Tests
//
//  Created by arnaud kiefer on 27/11/2021.
//

import XCTest
@testable import Reciplease_P_10

class SearchServiceTest: XCTestCase {

    // MARK: - Tests SearchService
    func testAddTwoIngredientAndRemoveAllThenListIsEmpty() throws {
        let s1 = SearchService.searchService
        let egg = "egg"
        s1.addIngredient(ingredient: egg)
        XCTAssertEqual(s1.ingredientListForResquest, egg.capitalized)
        let cream = "cream"
        s1.addIngredient(ingredient: cream)
        XCTAssertEqual(s1.ingredientListForResquest, "\(egg.capitalized) \(cream.capitalized)")
        s1.clearIngredients()
        XCTAssertEqual(s1.ingredientListForResquest, "")

    }

}
