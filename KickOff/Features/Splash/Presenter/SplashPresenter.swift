import Foundation

class SplashPresenter{
    
    var view : SplashViewProtocol
    
    init(view: SplashViewProtocol) {
        self.view = view
    }
    
    func start(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            if OnboardingManager.hasSeenOnboarding{
                self?.view.navigateToHome()
            }else{
                self?.view.navigateToOnBoarding()
                OnboardingManager.hasSeenOnboarding = true
            }
        }
    }
    
}
