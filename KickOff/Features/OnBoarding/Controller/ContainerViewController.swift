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
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "home")
        self.navigationController?.setViewControllers([homeVC], animated: true)
    }

}
