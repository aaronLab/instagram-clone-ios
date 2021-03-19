//
//  AuthenticationButton.swift
//  InstagramClone
//
//  Created by Aaron Lee on 2021/03/19.
//

import UIKit

class AuthenticationButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        layer.cornerRadius = 5
        setHeight(50)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    override func draw(_ rect: CGRect) {
        self.addTarget(self, action: #selector(animate), for: .touchUpInside)
    }
    
    @objc func animate() {
        
        self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
