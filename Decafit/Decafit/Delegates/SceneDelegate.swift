
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
         guard let windowScene = scene as? UIWindowScene else {
             return
         }
        let initialViewController: UIViewController
        let home = UINavigationController(rootViewController: HomeViewController())
        let authManager = AuthManager.shared
        switch authManager.isSignedIn {
        case true:
//            initialViewController = StartWorkoutViewController()
        initialViewController = home
        case false:
            initialViewController = LoginViewController()
        }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    }
}
