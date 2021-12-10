//
//  FavoritesTableViewController.swift
//  Reciplease_P_10
//
//  Created by arnaud kiefer on 22/11/2021.
//

import UIKit

class FavoritesTableViewController: UITableViewController {

    // MARK: - Properties
    var recipe: Recipe?
    var favorites: [Recipe] = []

    // MARK: - IBOutlets
    @IBOutlet var favoritesTableView: UITableView!

    // MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        favoritesTableView.register(nibName, forCellReuseIdentifier: "RecipeTableViewCell")
        favoritesTableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        completeFavoriteArray()
        favoritesTableView.reloadData()
        if FavoritesRecipesData.all.isEmpty{
            createAlert(message: "First, add Favorites Recipes on the search menu")
        }
    }

    // MARK: - Methods
    func completeFavoriteArray() {
        favorites.removeAll()
        for recipe in FavoritesRecipesData.all {
            let recipeToAppend = Recipe(uri: "-", label: recipe.label!, image: recipe.image!, source: "-", url: recipe.url!, shareAs: "-", yield: recipe.yield, dietLabels: [], healthLabels: [], ingredientLines: recipe.ingredientLines!.components(separatedBy: ","), ingredients: [], calories: 0.0, totalWeight: 0.0, totalTime: Int(recipe.totalTime), totalNutrients: [:], totalDaily: [:])
            favorites.append(recipeToAppend)
        }
        favoritesTableView.reloadData()
    }
}

// MARK: - Extension : TableView Configuration
extension FavoritesTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
        // cell configuration
        cell.commonInit(with: favorites[indexPath.row].image, title: favorites[indexPath.row].label, cookingTime: intTimeToString(time: favorites[indexPath.row].totalTime), like: "\(favorites[indexPath.row].yield)")
        return cell
    }

    // Click on the cell allows to go to the next viewController
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipe = favorites[indexPath.row]
        performSegue(withIdentifier: "FavoriteToDetail", sender: nil)
    }

    // Delete a recipe from the favorites via the context menu or by swipe the cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            FavoritesDataManagement.favoritesDataManagement.removeRecipe(recipeToRemove: favorites[indexPath.row])
            favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "FavoriteToDetail" {
            let detailVC = segue.destination as! DetailViewController
            // Send recipe on the next ViewController
            detailVC.recipe = recipe
        }
    }
}
