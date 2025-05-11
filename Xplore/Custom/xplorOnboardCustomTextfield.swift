//
//  xplorOnboardCustomTextfield.swift
//  Xplore
//
//  Created by Dilshad P on 10/05/25.
//

import UIKit

class xplorOnboardCustomTextfield: UITextField {

    var placeHolder: String!
    var isLastTextfiledInStack: Bool!

    
    init(placeholder: String, isLastTextfiledInStack: Bool) {
        super.init(frame: .zero)
        self.isLastTextfiledInStack = isLastTextfiledInStack
        placeHolder = placeholder
        isSecureTextEntry = isLastTextfiledInStack
        
        configureTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTextField() {
        translatesAutoresizingMaskIntoConstraints = false
        placeholder = placeHolder
        leftViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        autocapitalizationType = .none
        autocorrectionType = .no
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondaryLabel.cgColor
        backgroundColor = .systemGray
        
        
        if isLastTextfiledInStack {
            returnKeyType = .go
        }else {
            returnKeyType = .next
        }
        
    }
}
