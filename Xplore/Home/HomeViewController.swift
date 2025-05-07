//
//  ViewController.swift
//  Xplore
//
//  Created by Dilshad P on 06/05/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var placeImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.image = UIImage(named: "xplore")
        image.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        image.addGestureRecognizer(gesture)
        return image
    }()
    
    let placeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28,weight: .bold)
        return label
    }()
    
    lazy var distanceFromPlaceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Distance"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16,weight: .regular)
        label.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapDistanceLabel))
        label.addGestureRecognizer(gesture)
        return label
    }()
    
    lazy var shuffleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Xplore", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapShuffle), for: .touchUpInside)
        return button
    }()
    
    let categoryView = CategoryView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
        fetchplaces()
    }


    private func configureUI() {
        
        view.addSubview(placeImageView)
        view.addSubview(placeNameLabel)
        view.addSubview(distanceFromPlaceLabel)
        view.addSubview(categoryView)
        view.addSubview(shuffleButton)
        
        NSLayoutConstraint.activate([
            placeImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            placeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            placeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            placeImageView.heightAnchor.constraint(equalToConstant: 350),
            
            
            placeNameLabel.topAnchor.constraint(equalTo: placeImageView.bottomAnchor, constant: 12),
            placeNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeNameLabel.widthAnchor.constraint(equalToConstant: 200),
            placeNameLabel.heightAnchor.constraint(equalToConstant: 32),
            
            
            categoryView.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: 12),
            categoryView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categoryView.heightAnchor.constraint(equalToConstant: 48),
            
            
            distanceFromPlaceLabel.topAnchor.constraint(equalTo: categoryView.bottomAnchor, constant: 12),
            distanceFromPlaceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            distanceFromPlaceLabel.widthAnchor.constraint(equalToConstant: 200),
            distanceFromPlaceLabel.heightAnchor.constraint(equalToConstant: 48),
            
            
            shuffleButton.topAnchor.constraint(equalTo: distanceFromPlaceLabel.bottomAnchor, constant: 24),
            shuffleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -24),
            shuffleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            shuffleButton.heightAnchor.constraint(equalToConstant: 48),
            ])
            
    }
    
    
    @objc func didTapShuffle() {
        print("Shuffle tapped")
    }
    
    @objc func didTapImage() {
        print("image tapped")
    }
    
    @objc func didTapDistanceLabel() {
        print("image tapped")
    }
    
    private func fetchplaces() {
        let db = DatabaseServices()
        
        db.fetchPlaces { results in
            switch results {
            case .success(let success):
                print("success")
            case .failure(let failure):
                print("fail")
            }
        }
    }
}

#Preview {
    HomeViewController()
}
