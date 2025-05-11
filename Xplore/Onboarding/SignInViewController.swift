//
//  LoginViewController.swift
//  Xplore
//
//  Created by Dilshad P on 10/05/25.
//

import UIKit

class SignInViewController: UIViewController {
    
    let loginImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "xplore")
        return imageView
    }()
    
    lazy var registerText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "New User? SignUp Here"
        label.font = .systemFont(ofSize: 16)
        label.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapRegisterText))
        label.addGestureRecognizer(gesture)
        return label
    }()
    
    lazy var signInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        return button
    }()

    let emailTextField = xplorOnboardCustomTextfield(placeholder: "Email Address", isLastTextfiledInStack: false)
    let passwordTextField = xplorOnboardCustomTextfield(placeholder: "Password", isLastTextfiledInStack: true)
    
   let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(loginImageView)
        view.addSubview(stackView)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        emailTextField.delegate = self
        passwordTextField.delegate = self
        view.addSubview(registerText)
        view.addSubview(signInButton)
        
        NSLayoutConstraint.activate([
            
            loginImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            loginImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            loginImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            loginImageView.heightAnchor.constraint(equalToConstant: 300),
            
            stackView.topAnchor.constraint(equalTo: loginImageView.bottomAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            stackView.heightAnchor.constraint(equalToConstant: 150),
            
            registerText.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant:24),
            registerText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerText.heightAnchor.constraint(equalToConstant: 24),
            
            signInButton.topAnchor.constraint(equalTo: registerText.bottomAnchor, constant: 48),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func didTapRegisterText (){
        
        let vc = SignUpViewController()
        present(vc, animated: true)
    }
    
    @objc func didTapSignIn (){
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let email = emailTextField.text, !email.isEmpty, email.count > 5
        else {
            presentTextFieldError(textField: "email")
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty, password.count >= 8
        else {
            presentTextFieldError(textField: "password")
            return
        }
        
        AuthService.shared.loginUser(email: email, password: password) { result in
            switch result {
            case .success(_):
                print("success")
                let vc = PrimaryTabBarViewController()
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeViewcontroller(vc)
                
            case .failure(let failure):
                print("failure")
                print(failure.localizedDescription)
            }
        }
    }
    
    private func presentTextFieldError(textField: String) {
        
        if textField == "email" {
            let alert = UIAlertController(title: "Email Error", message: "Please Enter a valid email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive))
            present(alert, animated: true)
        }else if textField == "password" {
            let alert = UIAlertController(title: "Password Error", message: "Password must contail atletas least 8 characters", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive))
            present(alert, animated: true)
        }
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
            didTapSignIn()
        }
        return true
    }
}
