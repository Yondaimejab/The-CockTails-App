//
//  Cocktail.swift
//  ChallengeApp
//
//  Created by Oriontek on 11/30/19.
//  Copyright © 2019 JoelsTeam. All rights reserved.
//

import Foundation

class Cocktail  {
    var cocktailId: Int
    var name: String
    var imgUrl: String
    var instructions: String = ""
    var ingredients: [Ingredient]
    
    init() {
        cocktailId = 0
        name = ""
        imgUrl = ""
        instructions = ""
        ingredients = [Ingredient]()
    }
    
    init(cocktailFromJson: CocktailPreviewforSingleCocktail, ingredients: [Ingredient]){
        name = cocktailFromJson.strDrink
        imgUrl = cocktailFromJson.strDrinkThumb
        cocktailId = Int(cocktailFromJson.idDrink)!
        instructions = cocktailFromJson.strInstructions
        self.ingredients = ingredients
    }
}
