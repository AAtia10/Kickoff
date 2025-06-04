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
            
            self?.navigateToHome()
            
           }
        
        // Do any additional setup after loading the view.
    }
    
    
    func navigateToOnBoarding(){
        let onboardingStoryboard = UIStoryboard(name: "onBoarding", bundle: nil)
        let onboardingVC = onboardingStoryboard.instantiateViewController(withIdentifier: "OnBoardingViewController") as! OnBoardingViewController
        
        navigationController?.setViewControllers([onboardingVC], animated: true)
    }
    
    func navigateToHome(){
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "HomeTabBar") as? UITabBarController {
            self.navigationController?.setViewControllers([tabBarController], animated: true)
        }
    }
    
    
    


}

