//
//  UIAlertController+Extensions.swift
//  DinoCam
//
//  Created by Mario Vanegas on 2/7/21.
//

import UIKit

extension UIAlertController {
    static func showErrorAlert(description: String, completion: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: completion)
        alertController.addAction(action)
        
        return alertController
    }
    
    static func showSuccessAlert(description: String, completion: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: "Success", message: description, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: completion)
        alertController.addAction(action)
        
        return alertController
    }
}
