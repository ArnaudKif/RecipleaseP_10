//
//  RecipesTableViewController.swift
//  Reciplease_P_10
//
//  Created by arnaud kiefer on 22/11/2021.
//

import UIKit
import AlamofireImage

class RecipesTableViewController: UITableViewController {

    // MARK: - Properties
    var afRequest = AlamoRequest.alamoRequest
    var recipe: Recipe?
    var hit: [Hits]?

    // MARK: - IBOutlets
    @IBOutlet var recipeTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(recipeLoaded(notification:)), name: AlamoRequest.notificationRecipeLoaded, object: nil)
        recipeTableView.delegate = self
        recipeTableView.dataSource = self
        let nibName = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        recipeTableView.register(nibName, forCellReuseIdentifier: "RecipeTableViewCell")
        activityIndicator.isHidden = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hit = afRequest.recipe?.hits
        recipeTableView.reloadData()
    }

    // MARK: - Methods
    // Method executed when the recipe object is charged
    @objc func recipeLoaded(notification:Notification) {
        recipeTableView.reloadData()
        if let recipeCount = afRequest.recipe?.hits {
            hit = recipeCount
            if recipeCount.count == 0 {
                createAlert(message: "No recipe found with these ingredients")
            }
        }
        activityIndicator.isHidden = true
    }
}

// MARK: - Extension : TableView Configuration
extension RecipesTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let responseCount = afRequest.recipe?.hits.count {
            return responseCount
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
        if hit!.count > 1 {
            // cell configuration with recipe
            cell.commonInit(with: hit![indexPath.row].recipe.image, title: hit![indexPath.row].recipe.label, cookingTime: "\(hit![indexPath.row].recipe.totalTime)", like: "\(hit![indexPath.row].recipe.yield)")
            return cell
        } else {
            // cell configuration without recipe
            cell.commonInit(with: "photoRecette", title: "No recipe", cookingTime: "-", like: "-")
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipe = afRequest.recipe?.hits[indexPath.row].recipe
        performSegue(withIdentifier: "toRecipeDetail", sender: nil)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "toRecipeDetail" {
            let detailVC = segue.destination as! DetailViewController
            // Pass the selected object to the new view controller.
            detailVC.recipe = recipe
        }
    }
}
