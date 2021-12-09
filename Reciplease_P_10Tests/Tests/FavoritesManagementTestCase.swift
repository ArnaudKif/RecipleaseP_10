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
    func testAdd_Remove_FavoriteRecipe() {
        let vc = DetailViewController()
        vc.recipe = recipeForTest
        vc.removeFavorite()
        let count1 = FavoritesRecipesData.all.count
        vc.addFavorite()
        let count2 = FavoritesRecipesData.all.count
        XCTAssertEqual(count1 + 1, count2)
        vc.addOrRemoveFromFavorite()
        let count3 = FavoritesRecipesData.all.count
        XCTAssertEqual(count1, count3)
    }

    // MARK: - Tools for test : Properties
    let recipeForTest = Recipe(
        uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_9199ad45bd7fb16cda8d08c3e30771c2",
        label: "Lemon Sorbet",
        image: "https://www.edamam.com/web-img/78e/78ef0e463d0aadbf2caf7b6237cd5f12.jpg",
        source: "BBC Good Food", url: "http://www.bbcgoodfood.com/recipes/4583/",
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

}
