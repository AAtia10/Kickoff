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
           
          
           let deleteAction = UIAlertAction(title: NSLocalizedString("delete", comment: ""), style: .destructive) { _ in
               completion()
           }
           
           
           let cancelAction = UIAlertAction(title:NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil)
           
           alert.addAction(deleteAction)
           alert.addAction(cancelAction)
           
           viewController.present(alert, animated: true, completion: nil)
       }
    
    static func showNoInternetAlert(on viewController: UIViewController) {
        let alert = UIAlertController(title: NSLocalizedString("no_internet_connection", comment: ""), message: NSLocalizedString("internet_msg", comment: "") , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:NSLocalizedString("ok", comment: ""), style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
