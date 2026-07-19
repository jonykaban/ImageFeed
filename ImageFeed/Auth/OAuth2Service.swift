//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Никита Федоров on 23.06.2026.
//

import Foundation

enum AuthServiceError: Error {
    case invalidRequest
}

final class OAuth2Service {
    static let shared = OAuth2Service()

    private let tokenStorage = OAuth2TokenStorage()
    private let urlSession = URLSession.shared
    
    private var lastCode: String?
    private var task: URLSessionTask?
    
    private init() {}
    
    private func makeOAuthTokenRequest(code: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: "https://unsplash.com/oauth/token") else {
            assertionFailure("Failed to create URL")
            return nil
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "client_secret", value: Constants.secretKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code")
        ]
        
        guard let authTokenUrl = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: authTokenUrl)
        request.httpMethod = "POST"
        return request
    }
    
    func fetchAuthToken(code: String, completion: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)
        
        guard lastCode != code else {
            completion(.failure(AuthServiceError.invalidRequest))
            return
        }
        
        task?.cancel()
        lastCode = code
        
        guard let request = makeOAuthTokenRequest(code: code) else {
            lastCode = nil
            print("Invalid OAuth token request")
            completion(.failure(AuthServiceError.invalidRequest))
            return
        }
        
        let task = urlSession.data(for: request) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                
                guard self.lastCode == code else {
                    return
                }
                
                switch result {
                    
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(OAuthTokenResponseBody.self, from: data)
                        
                        let token = response.accessToken
                        self.tokenStorage.token = token
                        completion(.success(token))
                    } catch {
                        print("OAuth token request error: ", error)
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    print("OAuth token request error: ", error)
                    completion(.failure(error))
                }
                
                self.task = nil
                self.lastCode = nil
            }
        }
        self.task = task
        task.resume()
    }
}
