//
//  AuthManager.swift
//  Instagram
//
//  Created by Obed Garcia on 28/10/21.
//

import FirebaseAuth
import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    private init() { }
    
    let auth = Auth.auth()
    
    public var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    enum AuthError: Error {
        case userCreationError
        case failedSignIn
    }
    
    public func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        
        DatabaseManager.shared.getUser(with: email) { [weak self] user in
            guard let user = user else {
                completion(.failure(AuthError.failedSignIn))
                return
            }
            
            self?.auth.signIn(withEmail: email, password: password) { result, error in
                guard result != nil, error == nil else {
                    completion(.failure(AuthError.failedSignIn))
                    return
                }
                
                UserDefaults.standard.setValue(user.username, forKey: "username")
                UserDefaults.standard.setValue(user.email, forKey: "email")
                completion(.success(user))
            }
        }
    }
    
    public func signUp(email: String, username: String, profilePicture: Data?, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        let newUser = User(username: username, email: email)
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil,
                  error == nil else {
                completion(.failure(AuthError.userCreationError))
                return
            }
            
            DatabaseManager.shared.create(user: newUser) { isSaved in
                if isSaved {
                    StorageManager.shared.uploadProfilePicture(username: username, data: profilePicture) { didSavedImage in
                        if didSavedImage {
                            completion(.success(newUser))
                        } else {
                            completion(.failure(AuthError.userCreationError))
                        }
                    }
                } else {
                    completion(.failure(AuthError.userCreationError))
                }
            }
        }
    }
    
    public func signOut(completion: @escaping (Bool) -> Void) {
        do {
            try auth.signOut()
            completion(true)
        } catch {
            print(error)
            completion(false)
        }
    }
    
    
}
