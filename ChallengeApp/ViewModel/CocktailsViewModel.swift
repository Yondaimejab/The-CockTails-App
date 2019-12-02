//
//  CocktailsViewModel.swift
//  ChallengeApp
//
//  Created by Oriontek on 11/30/19.
//  Copyright © 2019 JoelsTeam. All rights reserved.
//

import Foundation
import UIKit

class CocktailsViewModel: BaseViewModel {
    private var cocktail: Cocktail = Cocktail()
    private var cocktailImage: UIImage? = nil
    
    
    func setCocktailWith(id: String, completion: @escaping (Bool) -> Void) {
        APIClient.requestForSingleCockTail(apiRequest: APIRequest<JSONObjectModelForCoctails>(
            routing: .getCocktail(id: id),
            decoder: JSONDecoder(),
            whileLoading: whileLoading, whenLoaded: { (cocktail) in
                self.cocktail = Cocktail(cocktailFromJson: cocktail.drinks[0].getCocktailInfo() ,ingredients:  cocktail.drinks[0].getIngredients())
                self.downloadImage(stringURL: self.cocktail.imgUrl)
                completion(true)
        }, onError:   { message in
            print(message)
        }))
    }
    
    func getCocktailName() -> String {
        return self.cocktail.name
    }
    
    func getCoctailImage() -> UIImage {
        if self.cocktailImage == nil {
          return UIImage()
        }
        return self.cocktailImage!
    }
    
    func getIngredients() -> [Ingredient] {
        return cocktail.ingredients
    }
    
    func getInstructions() -> String {
        return cocktail.instructions
    }
    
    private func downloadImage(stringURL: String) {
         if let imageUrl = URL(string: stringURL) {
               if let data = try? Data(contentsOf: imageUrl) {
                 if let image = UIImage(data: data) {
                     self.cocktailImage = image
                 }
             }
         }
     }
}
