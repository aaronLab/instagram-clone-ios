//
//  CustomTextField.swift
//  InstagramClone
//
//  Created by Aaron Lee on 2021/03/19.
//

import UIKit

class CustomtextField: UITextField {
    
    init(placeholder: String, keyboardType: UIKeyboardType? = nil) {
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        rightView = spacer
        rightViewMode = .always
        
        borderStyle = .none
        textColor = .white
        keyboardAppearance = .dark
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        setHeight(50)
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)]
        )
        
        if let keyboardType = keyboardType {
            self.keyboardType = keyboardType
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
