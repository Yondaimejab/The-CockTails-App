//
//  CocktailsApiRoute.swift
//  ChallengeApp
//
//  Created by Oriontek on 11/30/19.
//  Copyright © 2019 JoelsTeam. All rights reserved.
//

import Foundation
import Alamofire

enum CoctailsApiBaseConstants: String {
    case baseURL = "http://www.thecocktaildb.com"
    case singleCocktail = "/api/json/v1/1/lookup.php"
    case allCocktails = "/api/json/v1/1/filter.php"
}

enum CocktailsApiRoutes: URLRequestConvertible {
    case getCocktail(id: String)
    case getCocktails
    
    private var endPoint: String {
        switch self {
        case .getCocktail:
            return CoctailsApiBaseConstants.singleCocktail.rawValue
        default:
            return CoctailsApiBaseConstants.allCocktails.rawValue
        }
    }
    
    private var method : HTTPMethod {
        switch self {
        case .getCocktail:
            return .get
        default:
            return .get
        }
    }
    
    private var parameters : Parameters {
        switch self {
        case .getCocktail(let id):
            return ["i": id]
        default:
            return ["g":"Cocktail_glass"]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try (CoctailsApiBaseConstants.baseURL.rawValue + endPoint).asURL()
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        // With this you can set headers if needed
        // Request.setValue("1d830c27-c576-42c0-862c-412dfbc2e6b4", forHTTPHeaderField: "x-ibm-client-id")
        request = try URLEncoding(destination: .methodDependent).encode(request, with: parameters)
        return request
    }
}
