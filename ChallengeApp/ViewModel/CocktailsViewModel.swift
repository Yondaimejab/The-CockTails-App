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
    
    func setCocktailWith(id: String) async -> Bool {
        whileLoading()
        do {
            let route = CocktailsApiRoutes.getCocktail(id: id)
            let response: JSONObjectModelForCocktails? = try await APIClient.service.fetchObject(route: route)
            if let response, let drink = response.drinks.first {
                self.cocktail = .init(cocktailFromJson: drink.getCocktailInfo(), ingredients: drink.getIngredients())
                self.downloadImage(stringURL: self.cocktail.imgUrl)
                return true
            } else {
                return false
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func getCocktailName() -> String {
        return self.cocktail.name
    }
    
    func getCocktailImage() -> UIImage {
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
