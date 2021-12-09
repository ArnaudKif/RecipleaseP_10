//
//  ViewControllerExtension.swift
//  Reciplease_P_10
//
//  Created by arnaud kiefer on 08/12/2021.
//

import UIKit

extension UIViewController {
    // MARK: - Alert Methods
    // Create an alert with message
    func createAlert(message: String) {
        let alertVC = UIAlertController(title: "Alert !", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
