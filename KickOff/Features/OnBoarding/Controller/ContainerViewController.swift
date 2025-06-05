//
//  ContainerViewController.swift
//  KickOff
//
//  Created by Abdelrahman on 29/05/2025.
//

import UIKit

class ContainerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSkipClicked(_ sender: Any) {
        navigateToHome()
    }
    
    
    func navigateToHome() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "HomeTabBar") as? UITabBarController {
            
            if let viewControllers = tabBarController.viewControllers {
                if viewControllers.count > 0 {
                    viewControllers[0].tabBarItem.title = NSLocalizedString("home", comment: "")
                }
                if viewControllers.count > 1 {
                    viewControllers[1].tabBarItem.title = NSLocalizedString("fav", comment: "")
                }
            }
            self.navigationController?.setViewControllers([tabBarController], animated: true)
        }
    }

}
