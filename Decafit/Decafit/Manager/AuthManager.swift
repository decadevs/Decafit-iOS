import Foundation

protocol AuthManagerDelegate: AnyObject {
    func didShowAlert(title: String, message: String)
    func didDisplayIndicator()
}
final class AuthManager {
    static let shared = AuthManager()
    weak var delegate: AuthManagerDelegate?
    var successcomplete: ((Bool) -> Void)?
    public var isSignedIn: Bool {
        return true 
    }
    public func register(user: User) {
        
        let user =  RegisterInput(fullName: user.fullName, email: user.email,
                                  phoneNumber: user.phoneNumber, password: user.password)
        Network.shared.apollo.perform(mutation: RegisterMutation(user: user)) { [weak self] result in
//          ActivityIndicator.removeActivityIndicator(presenter: self)
          switch result {
          case .failure(let error):
            self?.delegate?.didShowAlert(title: "Network Error",
                                   message: error.localizedDescription)
            return
          case .success(let graphQLResult):
            if let registeredUser = graphQLResult.data?.register {
                print(registeredUser)
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
//          ActivityIndicator.removeActivityIndicator(presenter: self)
            self?.delegate?.didDisplayIndicator()

          switch result {
          case .failure(let error):
            self?.delegate?.didShowAlert(title: "Network Error",
                                   message: error.localizedDescription)
            return
          case .success(let graphQLResult):
            if let token = graphQLResult.data?.login {
//                ActivityIndicator.removeActivityIndicator(presenter: self)
                self?.delegate?.didDisplayIndicator()

              // Store the token in keychain
                print(token)
                self?.successcomplete?(true)
            }
            if let errors = graphQLResult.errors {
              let message = errors
                .map { $0.localizedDescription }
                             .joined(separator: "\n")
                self?.delegate?.didDisplayIndicator()
                print("=================== ", ActivityIndicator.self != nil ," ================")
                self?.delegate?.didShowAlert(title: "Error",
                                       message: message)
                print(message)
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
