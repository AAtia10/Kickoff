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
//               guard let self = self else { return }
//            let testVC  : TestViewController = storyboard?.instantiateViewController(withIdentifier: "test") as! TestViewController
//            navigationController?.setViewControllers([testVC], animated: true)
            
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
        let storyboard = UIStoryboard(name: "TeamDetails", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "teamDetails") as? TeamDetailsViewController {
            self.navigationController?.setViewControllers([tabBarController], animated: true)
        }
    }
    
    
    


}

