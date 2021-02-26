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

struct CocktailPreviewforSingleCocktail : Decodable {
    var strDrink: String
    var strDrinkThumb: String
    var idDrink: String
    var strInstructions: String
}

struct JSONObjectModelForCoctails: Decodable {
    var drinks: [JSONModelForCocktail]
}

struct CocktailsPreviewForSingleCocktail: Decodable {
    var drinks: [CocktailPreviewforSingleCocktail]
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

struct APIRequestCoctails<T> {
    var routing: CocktailsApiRoutes
    var decoder: JSONDecoder
    var whileLoading: () -> Void
    var whenLoaded: (T) -> Void
    var onError: (String) -> Void

}

struct APIClient {
    static let service = APIClient()
    var manager: SessionManager?
    
    init() {
        self.manager = Alamofire.SessionManager.default
        self.manager?.session.configuration.timeoutIntervalForRequest = 60
        self.manager?.session.configuration.timeoutIntervalForResource = 60
    }
    
    static func requestForSingleCockTail<T: Decodable>(apiRequest: APIRequest<T>) {
        apiRequest.whileLoading()
        self.service.manager?.request(apiRequest.routing).responseJSON(completionHandler: { response in
            switch response.result {
            case .success:
                let statusCode: Int = (response.response?.statusCode)!
                
                switch statusCode {
                case 200..<209:
                    do {
                        let data = try apiRequest.decoder.decode(T.self, from: response.data!)
                        // This is a dictionary that will be used to create the model a work around from the having all the ingredients in a diferent objects
                        apiRequest.whenLoaded(data)
                    } catch {
                        apiRequest.onError("asda")
                    }
                case 400..<451:
                    do {
                        if let response = try JSONSerialization.jsonObject(with: response.data!, options: []) as? [String: Any] {
                            apiRequest.onError(response["message"] as! String)
                        }
                    } catch {
                        apiRequest.onError("error")
                    }
                default:
                    apiRequest.onError("error")
                }
            case .failure:
                apiRequest.onError("error")
            }
        })
    }
    
    static func requestCocktails<T: Decodable>(apiRequest: APIRequestCoctails<T>) {
        apiRequest.whileLoading()
        self.service.manager?.request(apiRequest.routing).responseJSON(completionHandler: { response in
            switch response.result {
            case .success:
                let statusCode: Int = (response.response?.statusCode)!
                
                switch statusCode {
                case 200..<209:
                    do {
                        let data = try apiRequest.decoder.decode(T.self, from: response.data!)
                        // This is a dictionary that will be used to create the model a work around from the having all the ingredients in a diferent objects
                        apiRequest.whenLoaded(data)
                    } catch {
                        apiRequest.onError("error")
                    }
                case 400..<451:
                    do {
                        if let response = try JSONSerialization.jsonObject(with: response.data!, options: []) as? [String: Any] {
                            apiRequest.onError(response["message"] as! String)
                        }
                    } catch {
                        apiRequest.onError("error")
                    }
                default:
                    apiRequest.onError("error")
                }
            case .failure:
                apiRequest.onError("error")
            }
        })
    }
}
