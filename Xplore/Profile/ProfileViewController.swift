//
//  ProfileViewController.swift
//  Xplore
//
//  Created by Dilshad P on 10/05/25.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let imagewidth: CGFloat = 100
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.isUserInteractionEnabled = true
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.label.cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = imagewidth/2
        
        return imageView
    }()

    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Dilshad"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    lazy var signOutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SignOut", for: .normal)
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapSignOut), for: .touchUpInside)
    
        return button
    }()
    
    lazy var reportIssueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Report any issue", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(didTapSReportIssue), for: .touchUpInside)
        return button
    }()
    
    lazy var suggestionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Suggestions?", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(didTapSuggestion), for: .touchUpInside)
        return button
    }()
    
    let privacyPolicy: UILabel = {
        let label = UILabel()
        label.text = "Dilshad"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    let termsAndCondition: UILabel = {
        let label = UILabel()
        label.text = "Dilshad"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
       
    }
    
    private func configureUI() {
        view.addSubview(profileImageView)
        view.addSubview(usernameLabel)
        view.addSubview(signOutButton)
        view.addSubview(reportIssueButton)
        view.addSubview(suggestionButton)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: imagewidth),
            profileImageView.heightAnchor.constraint(equalToConstant: imagewidth),
            
            usernameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 24),
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 24),
            
            signOutButton.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor,constant: 50),
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signOutButton.widthAnchor.constraint(equalToConstant: 250),
            signOutButton.heightAnchor.constraint(equalToConstant: 50),
            
            reportIssueButton.topAnchor.constraint(equalTo: signOutButton.bottomAnchor,constant: 24),
            reportIssueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reportIssueButton.widthAnchor.constraint(equalToConstant: 150),
            reportIssueButton.heightAnchor.constraint(equalToConstant: 50),
            
            suggestionButton.topAnchor.constraint(equalTo: reportIssueButton.bottomAnchor,constant: 24),
            suggestionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            suggestionButton.widthAnchor.constraint(equalToConstant: 150),
            suggestionButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    
    @objc func didTapSignOut() {
        do{
            try AuthService.shared.signOut()
            let vc = SignInViewController()
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeViewcontroller(vc)
        }catch{
            print("Failed to signout")
        }
    }
    
    @objc func didTapSReportIssue() {
        print("SignOut Tapped")
    }
    
    @objc func didTapSuggestion() {
        print("SignOut Tapped")
    }
    
}

#Preview {
    ProfileViewController()
}
