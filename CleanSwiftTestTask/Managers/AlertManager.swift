//
//  AlertManager.swift
//  CleanSwiftTestTask
//
//  Created by Vlad Novik on 14.08.22.
//

import UIKit

enum AlertManager {
    struct ConfigurationModel {
        let title: String
        let subtitle: String
        let buttonText: String
        let action: (() -> Void)
    }
    
    static func showAlert(with model: ConfigurationModel, from vc: UIViewController) {
        let alert = UIAlertController(
            title: model.title,
            message: model.subtitle,
            preferredStyle: .alert
        )
        
        let button = UIAlertAction(title: model.buttonText, style: .default) { action in
            model.action()
        }
        
        alert.addAction(button)
        
        vc.present(alert, animated: true, completion: nil)
    }
}
