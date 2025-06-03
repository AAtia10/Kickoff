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
    
    
    func navigateToHome(){
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "HomeTabBar") as? UITabBarController {
            self.navigationController?.setViewControllers([tabBarController], animated: true)
        }
    }

}
