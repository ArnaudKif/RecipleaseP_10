//
//  SearchViewController.swift
//  Reciplease_P_10
//
//  Created by arnaud kiefer on 22/11/2021.
//

import UIKit
import Alamofire


class SearchViewController: UIViewController {

    // MARK: - Properties
    var search = SearchService.searchService
    var afRequest = AlamoRequest.alamoRequest

    // MARK: - IBOutlets
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var ingredientsListView: UITextView!
    @IBOutlet weak var searchButton: UIButton!

    // MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        //Dismiss the keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.ingredientTextField.delegate = self
        switchSearchButtonEnableState()
    }

    // MARK: - IBActions
    @IBAction func addButtonTaped() {
        addIngredient()
    }

    @IBAction func clearButtonTaped() {
        clearListText()
    }

    @IBAction func searchButtonTaped() {
        if search.ingredientList.count > 0 {
            afRequest.getRequest(ingredient: search.ingredientListForResquest, callback: { result in
                guard let result = result else {
                    return
                }
                if let data = result.value {
                    self.afRequest.recipe = data
                }
            })
        } else {
            createAlert(message: "Please enter an ingredient")
        }
    }

    // MARK: - Methods
    // Add ingredient in TextField if the text is correct
    func addIngredient() {
        let ingredientName = ingredientTextField.text!
        if ingredientName.isEmpty {
            createAlert(message: "Please enter an ingredient")
        } else if isOnFridge(ing: ingredientName) {
            createAlert(message: "This ingredient is already in the list")
        } else if ingredientName.isNumeric {
            createAlert(message: "Space, special or numerical character is not possible")
        } else {
            search.addIngredient(ingredient: ingredientTextField.text!)
            updateTextView()
            clearIngredientTextField()
        }
        switchSearchButtonEnableState()
    }

    // Check that the text is not already in the list
    func isOnFridge(ing: String) -> Bool {
        if (search.ingredientList.firstIndex(where: { $0 == ing.capitalized }) != nil) {
            return true
        } else {
            return false }
    }

    // Change the state of SearchButton
    private func switchSearchButtonEnableState() {
        if search.ingredientList.isEmpty {
            searchButton.isEnabled = false
        } else {
            searchButton.isEnabled = true
        }
    }

    // Clear the ListText
    private func clearListText() {
        ingredientsListView.text = ""
        search.clearIngredients()
        switchSearchButtonEnableState()
    }

    // Clear TextField
    private func clearIngredientTextField() {
        ingredientTextField.text = ""
    }

    // Update the textView
    func updateTextView() {
        var ingredientText = ""
        if search.ingredientList.count > 0 {
            for i in 0...(search.ingredientList.count-1) {
                ingredientText += "- " + search.ingredientList[i] + "\n"
            }
        } else {
            ingredientText = ""
        }
        ingredientsListView.text = ingredientText
    }
}

// MARK: - Extension : Keyboard Methods
extension SearchViewController: UITextFieldDelegate {

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        addIngredient()
        return false
    }
}



