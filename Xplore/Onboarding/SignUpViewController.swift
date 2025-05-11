//
//  SignUpViewController.swift
//  Xplore
//
//  Created by Dilshad P on 11/05/25.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    lazy var LoginText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Already resigstered? SignIn Here"
        label.font = .systemFont(ofSize: 16)
        label.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapLoginText))
        label.addGestureRecognizer(gesture)
        return label
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        return button
    }()

    let usernameTextField = xplorOnboardCustomTextfield(placeholder: "Username", isLastTextfiledInStack: false)
    let fullnameTextField = xplorOnboardCustomTextfield(placeholder: "Full Name", isLastTextfiledInStack: false)
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
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(fullnameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        usernameTextField.delegate = self
        fullnameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        view.addSubview(LoginText)
        view.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            
            
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            stackView.heightAnchor.constraint(equalToConstant: 300),
            
            LoginText.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant:24),
            LoginText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            LoginText.heightAnchor.constraint(equalToConstant: 24),
            
            signUpButton.topAnchor.constraint(equalTo: LoginText.bottomAnchor, constant: 48),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    }
    
    @objc func didTapLoginText() {
        print("didTapLoginText")
    }
    
    @objc func didTapSignUp() {
        usernameTextField.resignFirstResponder()
        fullnameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let username = usernameTextField.text, username.count >= 3, let fullname = fullnameTextField.text, let email = emailTextField.text,email.count > 5, let password = passwordTextField.text, password.count >= 8 else {
            return
        }
        
        AuthService.shared.registerUser(email: email, password: password, username: username, fullname: fullname) {[weak self] result in
            
            guard let strongSelf = self else {return}
            switch result {
            case .success(let success):
                print("succes:")
                print(success)
                strongSelf.dismiss(animated: true)
            case .failure(let failure):
                print("failure::")
                print(failure.localizedDescription)
            }
        }
    }
}

extension SignUpViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            fullnameTextField.becomeFirstResponder()
        }else if textField == fullnameTextField {
            emailTextField.resignFirstResponder()
        }else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
            didTapSignUp()
        }
        
        return true
    }
}
