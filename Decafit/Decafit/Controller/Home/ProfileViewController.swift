//
//  ProfileViewController.swift
//  Decafit
//
//  Created by Decagon on 02/09/2022.
//

import UIKit
import KeychainSwift
import Apollo

class ProfileViewController: UIViewController {
    weak var delegate: ProfileViewControllerDelegate?
    let keychain = KeychainSwift()
    let auth = AuthManager.shared
    let apolloSQ = Network.shared.apolloSQLite
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .white
        logoutBtn.frame = CGRect(x: 10, y: view.bounds.height-100, width: 280, height: 50)
        view.addSubview(logoutBtn)
        logoutBtn.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }
    
    @objc func logoutTapped() {
        delegate?.didTapLogout()
        auth.signOut()
        apolloSQ.clearCache()
        view.layoutIfNeeded()
        view.setNeedsDisplay()
        let screen = LoginViewController.getViewController()
        screen.modalPresentationStyle = .fullScreen
        present(screen, animated: true, completion: nil)
    }

    var logoutBtn: DecaButton = {
        let btn = DecaButton()
        btn.configure(with: DecaButtonViewModel(
                        title: Constants.logout, font: decaFont(size: 14, font: .poppinsMedium), backgroundColor: DecaColor.purple.color,
                        titleColor: .white, image: nil, borderWidth: 0,
                        cornerRadius: 5, borderColor: nil,
                        contentEdgeInsets: UIEdgeInsets(
                            top: 10, left: 12, bottom: 10, right: 12),
                        isEnabled: true, tarmic: true))
        return btn
    }()
    
}
