//
//  FavoritesTestCase.swift
//  Reciplease_P_10Tests
//
//  Created by arnaud kiefer on 02/12/2021.
//
import Foundation
import XCTest
@testable import Reciplease_P_10

class FavoritesTestCase: XCTestCase {


    // MARK: - Test FavoritesRecipes
    func testAdd_Remove_1Recipe() {

        let product1 = recipeForTest
        let context = TestContext.testContext
        let fakeDataManagement = FavoritesDataManagement(context: context)

        XCTAssertFalse(fakeDataManagement.isInFavorite(recipeUrl: product1.url))

        let count0 = fakeDataManagement.all.count
        fakeDataManagement.saveRecipe(recipeToSave: product1)
        let count1 = fakeDataManagement.all.count

        XCTAssertEqual(count0 + 1, count1)
        XCTAssertEqual(fakeDataManagement.all.first?.url, product1.url)
        XCTAssertTrue(fakeDataManagement.isInFavorite(recipeUrl: product1.url))

        fakeDataManagement.removeRecipe(recipeToRemove: product1)
        let count2 = fakeDataManagement.all.count
        XCTAssertEqual(count2, count0)
        XCTAssertFalse(fakeDataManagement.isInFavorite(recipeUrl: product1.url))
    }

    func testAdd_2RecipesToFavorite() {
        let product1 = recipeForTest
        let product2 = recipeForTest2
        let context = TestContext.testContext
        let fakeDataManagement = FavoritesDataManagement(context: context)

        XCTAssertFalse(fakeDataManagement.isInFavorite(recipeUrl: product1.url))
        XCTAssertFalse(fakeDataManagement.isInFavorite(recipeUrl: product2.url))

        fakeDataManagement.saveRecipe(recipeToSave: product1)
        fakeDataManagement.saveRecipe(recipeToSave: product2)
        let count1 = fakeDataManagement.all.count

        XCTAssertEqual(2, count1)
        XCTAssertEqual(fakeDataManagement.all.last?.url, product1.url)
        XCTAssertTrue(fakeDataManagement.isInFavorite(recipeUrl: product2.url))
        XCTAssertTrue(fakeDataManagement.isInFavorite(recipeUrl: product1.url))
    }

    // MARK: - Tools for test : Properties
    let recipeForTest = Recipe(
        uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_9199ad45bd7fb16cda8d08c3e30771c2",
        label: "Lemon Sorbet",
        image: "https://www.edamam.com/web-img/78e/78ef0e463d0aadbf2caf7b6237cd5f12.jpg",
        source: "BBC Good Food",
        url: "http://www.bbcgoodfood.com/recipes/4583/",
        shareAs: "http://www.edamam.com/recipe/lemon-sorbet-9199ad45bd7fb16cda8d08c3e30771c2/lemon",
        yield: 6.0,
        dietLabels: [],
        healthLabels: [],
        ingredientLines: ["500.0g caster sugar", "1 lemon , unwaxed, zested", "250 ml lemon juice (6-8 lemons)"],
        ingredients: [],
        calories: 2025.74,
        totalWeight: 894.0,
        totalTime: 0,
        totalNutrients: [:],
        totalDaily: [:])

    let recipeForTest2 = Recipe(
        uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_2a04bbc6d5ae6a8c4a02368a79ffc2e5",
        label: "Lemon Icey",
        image: "https://www.edamam.com/web-img/2c0/2c0ac2c82407335d6141e699a7442164.jpg",
        source: "Martha Stewart",
        url: "https://www.marthastewart.com/868405/lemon-icey",
        shareAs: "http://www.edamam.com/recipe/lemon-icey-2a04bbc6d5ae6a8c4a02368a79ffc2e5/lemon",
        yield: 7.0,
        dietLabels: [],
        healthLabels: [],
        ingredientLines: ["1 cup lemon juice (from 5-6 lemons)", "1 cup simple syrup"],
        ingredients: [],
        calories: 903.74,
        totalWeight: 564.0,
        totalTime: 1,
        totalNutrients: [:],
        totalDaily: [:])

}
