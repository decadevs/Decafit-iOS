import Foundation
import KeychainSwift

protocol AuthManagerDelegate: AnyObject {
    func didShowAlert(title: String, message: String)
}
final class AuthManager {
    static let shared = AuthManager()
    static let loginKeychainKey = Constants.loginText
    weak var delegate: AuthManagerDelegate?
    var successcomplete: ((Bool) -> Void)?
    let keychain = KeychainSwift()

    public var isSignedIn: Bool {
        return keychain.get(AuthManager.loginKeychainKey) != nil
//        return false
    }
    public func register(user: User) {
        
        let user =  RegisterInput(fullName: user.fullName, email: user.email,
                                  phoneNumber: user.phoneNumber, password: user.password)
        Network.shared.apollo.perform(mutation: RegisterMutation(user: user)) { [weak self] result in
          HUD.hide()
          switch result {
          case .failure(let error):
            self?.delegate?.didShowAlert(title: Constants.networkError,
                                   message: error.localizedDescription)
            return
          case .success(let graphQLResult):
            if graphQLResult.data?.userRegister != nil {
                self?.successcomplete?(true)
            }

            if let errors = graphQLResult.errors {
              let message = errors
                             .map { $0.localizedDescription }
                             .joined(separator: "\n")
                self?.delegate?.didShowAlert(title: Constants.alertTitleError, message: message)
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
            self?.delegate?.didShowAlert(title: Constants.networkError,
                                   message: error.localizedDescription)
            return
          case .success(let graphQLResult):
            if let data = graphQLResult.data?.userLogin {
                HUD.hide()
                guard let token = data.token else { return }
                self?.keychain.set(String(describing: token), forKey: AuthManager.loginKeychainKey)
                self?.keychain.set(data.id, forKey: Constants.userID)
                self?.successcomplete?(true)
            }
            if let errors = graphQLResult.errors {
              let message = errors
                .map { $0.localizedDescription }
                             .joined(separator: "\n")
                self?.delegate?.didShowAlert(title: Constants.alertTitleError,
                                       message: message)
                return
            }
          }
            
        }
    }
    
    public func signOut() {
        keychain.delete(AuthManager.loginKeychainKey)
    }
    @objc func handleSocialLogin() {
        
    }
    @objc func handleTextChange() {
    }
    
}
