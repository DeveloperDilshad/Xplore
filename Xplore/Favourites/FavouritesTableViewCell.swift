//
//  FavouritesTableViewCell.swift
//  Xplore
//
//  Created by Dilshad P on 09/05/25.
//

import UIKit
import SDWebImage

class FavouritesTableViewCell: UITableViewCell {
    
    static let identifier = "FavouritesTableViewCell"
    
    let placeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "xplore")
        return imageView
    }()
    
    let placeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .label
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(placeImageView)
        addSubview(placeNameLabel)
        
        NSLayoutConstraint.activate([
            placeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            placeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            placeImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 12),
            placeImageView.widthAnchor.constraint(equalToConstant: 75),
            
            placeNameLabel.leadingAnchor.constraint(equalTo: placeImageView.trailingAnchor, constant: 12),
            placeNameLabel.centerYAnchor.constraint(equalTo: placeImageView.centerYAnchor),
            placeNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),

            
        ])
    }
    
    public func configure(with model:Place){
        
        let url = URL(string: model.inageURL)
        placeImageView.sd_setImage(with: url)
        placeNameLabel.text = model.name
    }
}
