//
//  LoginViewController.swift
//  Bankey
//
//  Created by Martin on 2023/05/21.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}


protocol LogoutDelegate: AnyObject {
    func didLogout()
}

class LoginViewController: UIViewController {
    
    let mainTitle = UILabel()
    let subTitle = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    weak var delegate: LoginViewControllerDelegate?
    
    var username: String? {
        return loginView.usernameTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    enum TitleAnimation: CGFloat {
        case leadingEdgeOnScreen = 16
        case leadingEdgeOffScreen = -1000
    }
    
    var mainTitleLeadingAnchor: NSLayoutConstraint?
    var subTitleLeadingAnchor: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }


}

extension LoginViewController {
    private func style() {
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        mainTitle.textAlignment = .center
        mainTitle.font = .preferredFont(forTextStyle: .largeTitle)
        mainTitle.text = "Bankey"
        mainTitle.alpha = 0
        
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.textAlignment = .center
        subTitle.font = .preferredFont(forTextStyle: .title3)
        subTitle.text = "Your premium source for all things banking!"
        subTitle.numberOfLines = 2
        subTitle.alpha = 0
        
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
    }
    
    private func layout() {
        view.addSubview(mainTitle)
        view.addSubview(subTitle)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        // Title
        NSLayoutConstraint.activate([
            mainTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        mainTitleLeadingAnchor = mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: TitleAnimation.leadingEdgeOffScreen.rawValue)
        mainTitleLeadingAnchor?.isActive = true
        
        // SubTitle
        NSLayoutConstraint.activate([
            subTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            subTitle.topAnchor.constraint(equalToSystemSpacingBelow: mainTitle.bottomAnchor, multiplier: 3),
        ])
        subTitleLeadingAnchor = subTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: TitleAnimation.leadingEdgeOffScreen.rawValue)
        subTitleLeadingAnchor?.isActive = true
        
        // LoginView
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: subTitle.bottomAnchor, multiplier: 3),
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
        
        // Button
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        // Error Message Label
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
    }
}
// MARK: - Actions
extension LoginViewController {
    @objc func signInTapped(sender: UIButton) {
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username / Password Should never be nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password cannot be blank")
            return
        }
        
        if username == "Seokjun" && password == "welcome" {
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        } else {
            configureView(withMessage: "Incorrect username / password")
        }
    }
    
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
}

// MARK: - Animations
extension LoginViewController {
    private func animate() {
        let duration: CGFloat = 2.0
        let mainTitleAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.mainTitleLeadingAnchor?.constant = TitleAnimation.leadingEdgeOnScreen.rawValue
            self.view.layoutIfNeeded()
        }
        
        let subTitleAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.subTitleLeadingAnchor?.constant = TitleAnimation.leadingEdgeOnScreen.rawValue
            self.view.layoutIfNeeded()
        }
        
        let transparencyAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.mainTitle.alpha = 1
            self.subTitle.alpha = 1
        }
        
        
        mainTitleAnimator.startAnimation()
        transparencyAnimator.startAnimation(afterDelay: duration * 0.8)
        subTitleAnimator.startAnimation(afterDelay: duration)
    }
}
