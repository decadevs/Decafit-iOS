import Foundation
import KeychainSwift

protocol AuthManagerDelegate: AnyObject {
    func didShowAlert(title: String, message: String)
}
final class AuthManager {
    static let shared = AuthManager()
    static let loginKeychainKey = "login"
    weak var delegate: AuthManagerDelegate?
    var successcomplete: ((Bool) -> Void)?
    let keychain = KeychainSwift()

    public var isSignedIn: Bool {
//        return keychain.get(AuthManager.loginKeychainKey) != nil
        return true 
    }
    public func register(user: User) {
        
        let user =  RegisterInput(fullName: user.fullName, email: user.email,
                                  phoneNumber: user.phoneNumber, password: user.password)
        Network.shared.apollo.perform(mutation: RegisterMutation(user: user)) { [weak self] result in
            HUD.hide()
          switch result {
          case .failure(let error):
            self?.delegate?.didShowAlert(title: "Network Error",
                                   message: error.localizedDescription)
            return
          case .success(let graphQLResult):
            if let registeredUser = graphQLResult.data?.register {
                self?.successcomplete?(true)
            }

            if let errors = graphQLResult.errors {
              let message = errors
                             .map { $0.localizedDescription }
                             .joined(separator: "\n")
                self?.delegate?.didShowAlert(title: "Something is wrong!",
                                       message: message)
                return
            }

          }
            
        }
    }
    
    public func login(user: LoginInput) {
        let user = LoginInput(email: user.email, password: user.password)
        Network.shared.apollo.perform(mutation: LoginMutation(user: user)) { [weak self] result in
            HUD.hide()
          switch result {
          case .failure(let error):
            HUD.hide()
            self?.delegate?.didShowAlert(title: "Network Error",
                                   message: error.localizedDescription)
            return
          case .success(let graphQLResult):
            if let token = graphQLResult.data?.login.token {
                HUD.hide()
                self?.keychain.set(String(describing: token), forKey: AuthManager.loginKeychainKey)
                self?.successcomplete?(true)
            }
            if let errors = graphQLResult.errors {
              let message = errors
                .map { $0.localizedDescription }
                             .joined(separator: "\n")
                self?.delegate?.didShowAlert(title: "Error",
                                       message: message)
                return
            }
          }
            
        }
    }
    
    public func signOut() {
    }
    @objc func handleSocialLogin() {
        
    }
    @objc func handleTextChange() {
    }
    
}
