//
//  AlertManager.swift
//  KickOff
//
//  Created by Abdelrahman Atia on 02/06/2025.
//

import Foundation
import UIKit
class AlertManager{
    
    static func showDeleteAlert(on viewController: UIViewController, title: String, message: String, completion: @escaping () -> Void) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
          
           let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
               completion()
           }
           
           
           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           
           alert.addAction(deleteAction)
           alert.addAction(cancelAction)
           
           viewController.present(alert, animated: true, completion: nil)
       }
    
    static func showNoInternetAlert(on viewController: UIViewController) {
        let alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
