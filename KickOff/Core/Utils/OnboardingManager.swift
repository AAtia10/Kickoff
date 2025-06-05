import Foundation

class OnboardingManager {
    private static let hasSeenOnboardingKey = "hasSeenOnboarding"

    static var hasSeenOnboarding: Bool {
        get {
            return UserDefaults.standard.bool(forKey: hasSeenOnboardingKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: hasSeenOnboardingKey)
        }
    }
    static func resetOnboarding() {
        UserDefaults.standard.removeObject(forKey: hasSeenOnboardingKey)
    }
}
