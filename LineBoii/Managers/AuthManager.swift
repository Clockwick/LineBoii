//
//  AuthManager.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 25/7/2564 BE.
//

import Foundation
import LineSDK

class AuthManager {
    static let shared = AuthManager()

    private var refreshingToken: Bool = false

    private init() {}
    
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else {
            return false
        }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    public func cacheToken(accessToken: String, expirationDate: Date) {
        UserDefaults.standard.setValue(accessToken, forKey: "access_token")
        UserDefaults.standard.setValue(expirationDate, forKey: "expirationDate")
    }
    
    private var onRefreshBlocks = [((String) -> Void)]()
    
    /// Supplies valid token to be used with API Calls
    public func withValidToken(completion: @escaping (String) -> Void) {
        guard !refreshingToken else {
            // Append the completion
            onRefreshBlocks.append(completion)
            return
        }
        
        if shouldRefreshToken {
            // Refresh
            refreshIfNeeded { [weak self] (success) in
                if success {
                    if let token = self?.accessToken, success {
                        completion(token)
                    }
                }
            }
            
        } else if let token = accessToken {
            completion(token)
        }
    }
    
    public func isValidToken(completion: @escaping ((String) -> Void)) {
        
        guard !refreshingToken else {
            onRefreshBlocks.append(completion)
            return
        }
        guard let accessToken = accessToken else {
            return
        }
        
        guard let url = URL(string: "https://api.line.me/oauth2/v2.1/verify?access_token=\(accessToken)") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _ , error in
            guard error == nil else {
                return
            }
            self?.refreshIfNeeded(completion: nil)
            completion(accessToken)
        }
        task.resume()
    }
    
    public func refreshIfNeeded(completion: ((Bool) -> Void)?) {
        guard !refreshingToken else {
            return
        }
        
        guard shouldRefreshToken else {
            completion?(true)
            return
        }
        
        refreshingToken = true
        
        API.Auth.refreshAccessToken { [weak self] result in
            switch result {
            case .success(_):
                guard let token = AccessTokenStore.shared.current else {
                    return
                }
                self?.onRefreshBlocks.removeAll()
                let accessToken = token.value
                let expirationDate = token.expiresAt
                AuthManager.shared.cacheToken(accessToken: accessToken, expirationDate: expirationDate)
                self?.refreshingToken = false
            case .failure(let error):
                print(error)
            }
        }

        
    }
    
    public func signOut(completion: @escaping ((Bool) -> Void)) {
        UserDefaults.standard.setValue(nil, forKey: "access_token")
        UserDefaults.standard.setValue(nil, forKey: "expirationDate")
        completion(true)
    }
}


