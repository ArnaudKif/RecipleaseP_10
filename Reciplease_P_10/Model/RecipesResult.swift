//
//  RecipesResult.swift
//  Reciplease_P_10
//
//  Created by arnaud kiefer on 22/11/2021.
//

import Foundation

struct RecipesResult: Decodable {
    let from: Int
    let to: Int
    let count: Int
    let _links: Links
    let hits: [Hits]
}

struct Links: Decodable {
    let next: Link
}

struct Link: Decodable {
    let href: String
    let title: String
}

struct Hits: Decodable {
    let recipe: Recipe
}

struct Recipe: Decodable {
    let uri: String
    let label: String
    let image: String
    let source: String
    let url: String
    let shareAs: String
    let yield: Double
    let dietLabels, healthLabels: [String]
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    let calories, totalWeight: Double
    let totalTime: Int
    let totalNutrients, totalDaily: [String: Total]
}

enum Unit: String, Codable {
    case empty = "%"
    case g = "g"
    case iu = "IU"
    case kcal = "kcal"
    case mg = "mg"
    case µg = "µg"
}

struct Ingredient: Decodable {
    let text: String
    let weight: Double
}

struct Total: Decodable {
    let label: String
    let quantity: Double
    let unit: Unit
}
