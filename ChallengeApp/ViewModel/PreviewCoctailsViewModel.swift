//
//  PreviewCoctailsViewModel.swift
//  ChallengeApp
//
//  Created by Oriontek on 12/1/19.
//  Copyright © 2019 JoelsTeam. All rights reserved.
//

import Foundation
import UIKit

class PreviewCoctailsViewModel: BaseViewModel {
    var cocktailsPreviews = [CocktailPreview]()
    var cocktailImages : [Int : UIImage] = [:]
        
    func requestCocktails() {
        APIClient.requestCocktails(apiRequest: APIRequestCoctails<CocktailsPreview>(
            routing: CocktailsApiRoutes.getCocktails,
            decoder: JSONDecoder(),
            whileLoading: whileLoading,
            whenLoaded: { (cocktailPreviews) in
                self.cocktailsPreviews = cocktailPreviews.drinks
                self.downloadImages()
        }, onError: { message in
            print(message)
        }))
    }
    
    func getImageWith(id: Int) -> UIImage {
        return self.cocktailImages[id]!
    }
    
    private func downloadImages() {
        for item in cocktailsPreviews {
            downloadImage(stringURL: item.strDrinkThumb, key: Int(item.idDrink)!)
        }
    }
    
    // Use this method to parse img from given URL
    private func downloadImage(stringURL: String,key: Int) {
        if let imageUrl = URL(string: stringURL) {
              DispatchQueue.global().async {
                  if let data = try? Data(contentsOf: imageUrl) {
                    if let image = UIImage(data: data) {
                     self.cocktailImages[key] = image
                    }else {
                        self.cocktailImages[key] = UIImage()
                    }
                  }else {
                    print("asdasd")
                    self.cocktailImages[key] = UIImage()
                }
            }
        }
    }
}
