//
//  CategoryView.swift
//  Xplore
//
//  Created by Dilshad P on 07/05/25.
//

import UIKit

class CategoryView: UIView {
    
    let catogoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Category"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    let circleImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "circle.fill")
        return image
        
    }()

    override init(frame: CGRect) {
        super.init(frame:frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(catogoryLabel)
        addSubview(circleImageView)
        
        NSLayoutConstraint.activate([
            catogoryLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            catogoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            catogoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-8),
            catogoryLabel.heightAnchor.constraint(equalToConstant: 24),
            
            
            circleImageView.trailingAnchor.constraint(equalTo: catogoryLabel.leadingAnchor, constant: -8),
            circleImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            circleImageView.widthAnchor.constraint(equalToConstant: 20),
            circleImageView.heightAnchor.constraint(equalToConstant: 20),
            
        ])
    }
    
    func setCategory(category:String){
        catogoryLabel.text = category
        
        if category == "Food"{
            catogoryLabel.textColor = .systemOrange
            circleImageView.tintColor = .systemOrange
        }else if category == "city"{
            catogoryLabel.textColor = .systemBlue
            circleImageView.tintColor = .systemBlue
        }else if category == "Nature"{
            catogoryLabel.textColor = .systemGreen
            circleImageView.tintColor = .systemGreen
        }else if category == "Hotel"{
            catogoryLabel.textColor = .systemPurple
            circleImageView.tintColor = .systemPurple
        }
    }
}
