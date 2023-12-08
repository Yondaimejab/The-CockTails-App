//
//  ApiClient.swift
//  ChallengeApp
//
//  Created by Oriontek on 11/30/19.
//  Copyright © 2019 JoelsTeam. All rights reserved.
//

import Foundation
import Alamofire


struct CocktailPreview : Decodable {
    var strDrink: String
    var strDrinkThumb: String
    var idDrink: String
}

struct CocktailPreviewForSingleCocktail : Decodable {
    var strDrink: String
    var strDrinkThumb: String
    var idDrink: String
    var strInstructions: String
}

struct JSONObjectModelForCocktails: Decodable {
    var drinks: [JSONModelForCocktail]
}

struct CocktailsPreviewForSingleCocktail: Decodable {
    var drinks: [CocktailPreviewForSingleCocktail]
}

struct CocktailsPreview: Decodable {
    var drinks: [CocktailPreview]
}

struct APIRequest<T> {
    var routing: CocktailsApiRoutes
    var decoder: JSONDecoder
    var whileLoading: () -> Void
    var whenLoaded: (T) -> Void
    var onError: (String) -> Void

}

struct APIClient {
    static let service = APIClient()
    private var session: URLSession?
    
    enum NetworkError: Error {
        case standard(error: Error)
        case message(text: String)
        case invalidStatusCode(_ code: Int)
    }
    
    private init() {
        session = AF.session
        session?.configuration.timeoutIntervalForRequest = 60
    }
    
    func fetchObject<T: Decodable>(route: URLRequestConvertible) async throws -> T? {
        let validatedDataRequest = AF.request(route).validate()
        guard validatedDataRequest.error == nil else {
            if let data = validatedDataRequest.data {
                if let errorMessage = try? JSONDecoder().decode(ErrorMessage.self, from: data) {
                    throw NetworkError.message(text: errorMessage.value)
                }
            }
            throw validatedDataRequest.error!
        }
        let response = await validatedDataRequest.serializingDecodable(T.self).response
        return response.value
    }
}
