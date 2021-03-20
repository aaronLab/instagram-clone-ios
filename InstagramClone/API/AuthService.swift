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
    
    func registerUser(with credentials: AuthCredentials, completion: @escaping (Error?) -> Void) {
        
        ImageUploader.shared.uploadImage(image: credentials.profileImage) { imageUrl in
            Auth.auth().createUser(
                withEmail: credentials.email,
                password: credentials.email) { result, error in
                
                if let error = error {
                    print("DEBUG: Failed to register user \(error.localizedDescription)")
                    return
                }
                
                guard let uid = result?.user.uid else { return }
                
                let data: [String: Any] = [
                    "email": credentials.email,
                    "fullname": credentials.fullname,
                    "profileImageUrl": imageUrl,
                    "uid": uid,
                    "username": credentials.username
                ]
                
                Firestore.firestore()
                    .collection("users")
                    .document(uid)
                    .setData(data, completion: completion)
                
            }
        }
        
    }
    
    func logUserIn(email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
}
