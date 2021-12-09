//
//  StringExtension.swift
//  Reciplease_P_10
//
//  Created by arnaud kiefer on 07/12/2021.
//

import Foundation
import UIKit

extension String {
    // Check if the text content only letters
    var isNumeric: Bool {
        return self.trimmingCharacters(in: .letters) != String() ? true : false
    }
}
