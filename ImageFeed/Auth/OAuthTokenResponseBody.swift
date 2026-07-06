//
//  OAuthTokenResponseBody.swift
//  ImageFeed
//
//  Created by Никита Федоров on 30.06.2026.
//

import Foundation

struct OAuthTokenResponseBody: Decodable {
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}
