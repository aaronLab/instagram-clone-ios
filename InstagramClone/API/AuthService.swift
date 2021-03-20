//
//  AuthService.swift
//  InstagramClone
//
//  Created by Aaron Lee on 2021/03/20.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    
    static let shared = AuthService()
    
    private init() {}
    
    func registerUser(with credentials: AuthCredentials) {
        print("DEBUG: Credentials are \(credentials)")
    }
}
