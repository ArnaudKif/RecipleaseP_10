//
//  DetailViewController.swift
//  Reciplease_P_10
//
//  Created by arnaud kiefer on 22/11/2021.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {

    // MARK: - Properties
    var recipe: Recipe?
    let favManagement = FavoritesDataManagement.favoritesDataManagement
    let whiteStar: UIColor = #colorLiteral(red: 0.9799543023, green: 0.9601166844, blue: 0.9604731202, alpha: 1)
    let orangeStar: UIColor = #colorLiteral(red: 0.9813225865, green: 0.7072252457, blue: 0.4114859518, alpha: 1)

    // MARK: - IBOutlets
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var favStarIcon: UIButton!
    @IBOutlet weak var ingredientTableView: UITableView!

    // MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        recipeDisplayUpdate()
       switchStarImage()
    }

    // MARK: - IBActions
    @IBAction func favButtonTaped(_ sender: Any) {
        addOrRemoveFromFavorite()
    }

    @IBAction func GetButtonTaped(_ sender: Any) {
        // Open the website with the url of the recipe
        if let urlLink = recipe?.url {
            guard let url = URL(string: urlLink) else { return }
            UIApplication.shared.open(url)
        } else {
            createAlert(message: "Link for recipe missing")
        }
    }

    // MARK: - Methods
    // updates the recipe display and load the photo
    func recipeDisplayUpdate() {
        if recipe != nil {
            timeLabel.text = intTimeToString(time: recipe!.totalTime)
            likeLabel.text = "\(recipe!.yield)"
            recipeTitleLabel.text = recipe!.label
            guard let url = URL(string: recipe!.image) else {
                recipeImage.image = UIImage(named: "photoRecette")
                return
            }
            recipeImage.af.setImage(withURL: url)
            switchStarImage()
        }
    }

    // Launches the addition or deletion of the recipe if it is in the favorites
    func addOrRemoveFromFavorite() {
        if isInFavorites() {
            removeFavorite()
        } else {
            addFavorite()
        }
        switchStarImage()
    }

    // Add recipe to favorites
    func addFavorite() {
        favManagement.saveRecipe(recipeToSave: recipe!)
       changeColorInOrange()
    }

    // Delete recipe of favorites
    func removeFavorite() {
        favManagement.removeRecipe(recipeToRemove: recipe!)
       changeColorInWhite()
    }

    // Change the color of star and title
    func switchStarImage() {
        if isInFavorites() {
            changeColorInOrange()
        } else {
          changeColorInWhite()
        }
    }

    // Change the color of the title and the star to orange
    func changeColorInOrange() {
        favStarIcon?.tintColor = orangeStar
        recipeTitleLabel?.textColor = orangeStar
    }

    // Change the color of the title and the star to white
    func changeColorInWhite() {
        favStarIcon?.tintColor = whiteStar
        recipeTitleLabel?.textColor = whiteStar
    }

    // Check if the recipe is in favorites
    func isInFavorites() -> Bool {
        if (FavoritesRecipesData.all.firstIndex(where: { $0.label == recipe?.label }) != nil) {
            return true
        } else { return false }
    }
}

// MARK: - Extension : TableView Configuration
extension DetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe?.ingredientLines.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientListCell", for: indexPath)
        guard let ingredientsRecipe = recipe?.ingredientLines[indexPath.row] else { return UITableViewCell() }
        // cell configuration
        cell.textLabel?.text = "- \(ingredientsRecipe)"
        cell.textLabel?.textColor = whiteStar
        cell.textLabel?.font = UIFont.init(name: "Bradley Hand", size: 20)
        return cell
    }
}
