//
//  ViewController.swift
//  KickOff
//
//  Created by Abdelrahman Atia on 29/05/2025.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
  
    @IBOutlet weak var animationView: LottieAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        animationView.contentMode = .scaleAspectFit
          
        animationView.loopMode = .loop
          
          
        animationView.animationSpeed = 0.5
          
        animationView.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            
            self?.navigateToOnBoarding()
            
           }
        
        // Do any additional setup after loading the view.
    }
    
    
    func navigateToOnBoarding(){
        let onboardingStoryboard = UIStoryboard(name: "onBoarding", bundle: nil)
        let onboardingVC = onboardingStoryboard.instantiateViewController(withIdentifier: "OnBoardingViewController") as! OnBoardingViewController
        
        navigationController?.setViewControllers([onboardingVC], animated: true)
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

