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
            
            self?.navigationOnBoarding()
            
           }
        
        // Do any additional setup after loading the view.
    }
    
    
    func navigationOnBoarding(){
        let onboardingStoryboard = UIStoryboard(name: "onBoarding", bundle: nil)
        let onboardingVC = onboardingStoryboard.instantiateViewController(withIdentifier: "OnBoardingViewController") as! OnBoardingViewController
        
        navigationController?.setViewControllers([onboardingVC], animated: true)
    }


}

