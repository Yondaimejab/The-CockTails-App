//
//  JSONModelForCocktails.swift
//  ChallengeApp
//
//  Created by Oriontek on 12/1/19.
//  Copyright © 2019 JoelsTeam. All rights reserved.
//

import Foundation

class JSONModelForCocktail: Decodable {
    var idDrink: String
    var strDrink:  String
    var strInstructions: String
    var strDrinkThumb: String
    var strIngredient1: String?
    var strIngredient2: String?
    var strIngredient3: String?
    var strIngredient4: String?
    var strIngredient5: String?
    var strIngredient6: String?
    var strIngredient7: String?
    var strIngredient8: String?
    var strIngredient9: String?
    var strIngredient10: String?
    var strIngredient11: String?
    var strIngredient12: String?
    var strIngredient13: String?
    var strIngredient14: String?
    var strIngredient15: String?
    var strMeasure1: String?
    var strMeasure2: String?
    var strMeasure3: String?
    var strMeasure4: String?
    var strMeasure5: String?
    var strMeasure6: String?
    var strMeasure7: String?
    var strMeasure8: String?
    var strMeasure9: String?
    var strMeasure10: String?
    var strMeasure11: String?
    var strMeasure12: String?
    var strMeasure13: String?
    var strMeasure14: String?
    var strMeasure15: String?
    
    enum codingKeys: CodingKey {
        case idDrink
        case strDrink
        case strInstructions
        case strDrinkThumb
        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        case strIngredient11
        case strIngredient12
        case strIngredient13
        case strIngredient14
        case strIngredient15
        case strMeasure1
        case strMeasure2
        case strMeasure3
        case strMeasure4
        case strMeasure5
        case strMeasure6
        case strMeasure7
        case strMeasure8
        case strMeasure9
        case strMeasure10
        case strMeasure11
        case strMeasure12
        case strMeasure13
        case strMeasure14
        case strMeasure15
        
    }
    
    required init(from decoder:Decoder) throws {
         let values = try decoder.container(keyedBy: codingKeys.self)
         idDrink = try values.decode(String.self, forKey: .idDrink)
         strDrink = try values.decode(String.self, forKey: .strDrink)
         strInstructions = try values.decode(String.self, forKey: .strInstructions)
         strDrinkThumb = try values.decode(String.self, forKey: .strDrinkThumb)
         strIngredient1 = try values.decodeIfPresent(String.self, forKey: .strIngredient1)
         strIngredient2 = try values.decodeIfPresent(String.self, forKey: .strIngredient2)
         strIngredient3 = try values.decodeIfPresent(String.self, forKey: .strIngredient3)
         strIngredient4 = try values.decodeIfPresent(String.self, forKey: .strIngredient4)
         strIngredient5 = try values.decodeIfPresent(String.self, forKey: .strIngredient5)
         strIngredient6 = try values.decodeIfPresent(String.self, forKey: .strIngredient6)
         strIngredient7 = try values.decodeIfPresent(String.self, forKey: .strIngredient7)
         strIngredient8 = try values.decodeIfPresent(String.self, forKey: .strIngredient8)
         strIngredient9 = try values.decodeIfPresent(String.self, forKey: .strIngredient9)
         strIngredient10 = try values.decodeIfPresent(String.self, forKey: .strIngredient10)
         strIngredient11 = try values.decodeIfPresent(String.self, forKey: .strIngredient11)
         strIngredient12 = try values.decodeIfPresent(String.self, forKey: .strIngredient12)
         strIngredient13 = try values.decodeIfPresent(String.self, forKey: .strIngredient13)
         strIngredient14 = try values.decodeIfPresent(String.self, forKey: .strIngredient14)
         strIngredient15 = try values.decodeIfPresent(String.self, forKey: .strIngredient15)
         strMeasure1 = try values.decodeIfPresent(String.self, forKey: .strMeasure1)
         strMeasure2 = try values.decodeIfPresent(String.self, forKey: .strMeasure2)
         strMeasure3 = try values.decodeIfPresent(String.self, forKey: .strMeasure3)
         strMeasure4 = try values.decodeIfPresent(String.self, forKey: .strMeasure4)
         strMeasure5 = try values.decodeIfPresent(String.self, forKey: .strMeasure5)
         strMeasure6 = try values.decodeIfPresent(String.self, forKey: .strMeasure6)
         strMeasure7 = try values.decodeIfPresent(String.self, forKey: .strMeasure7)
         strMeasure8 = try values.decodeIfPresent(String.self, forKey: .strMeasure8)
         strMeasure9 = try values.decodeIfPresent(String.self, forKey: .strMeasure9)
         strMeasure10 = try values.decodeIfPresent(String.self, forKey: .strMeasure10)
         strMeasure11 = try values.decodeIfPresent(String.self, forKey: .strMeasure11)
         strMeasure12 = try values.decodeIfPresent(String.self, forKey: .strMeasure12)
         strMeasure13 = try values.decodeIfPresent(String.self, forKey: .strMeasure13)
         strMeasure14 = try values.decodeIfPresent(String.self, forKey: .strMeasure14)
         strMeasure15 = try values.decodeIfPresent(String.self, forKey: .strMeasure15)
    }
    
    func getIngredients() -> [Ingredient] {
        var ingredients = [Ingredient]()
        var ingredientsArray : [String?] = [
            strIngredient1,strIngredient2,strIngredient3,strIngredient4,strIngredient5,strIngredient6,
            strIngredient7,strIngredient8,strIngredient9,strIngredient10,strIngredient11,strIngredient12,
            strIngredient13,strIngredient14,strIngredient15
        ]
        var measureArray : [String?] = [
            strMeasure1,strMeasure2,strMeasure3,strMeasure4,strMeasure5,strMeasure6,
            strMeasure7,strMeasure8,strMeasure9,strMeasure10,strMeasure11,strMeasure12,
            strMeasure13,strMeasure14,strMeasure15
        ]
        for item in 0...14 {
            if let ingredientName = ingredientsArray[item] {
              if let measureAmount = measureArray[item] {
                ingredients.append(Ingredient(named: ingredientName, inMeasure: measureAmount))
              }
            }
        }
        return ingredients
    }
    
    func getCocktailInfo() -> CocktailPreviewForSingleCocktail {
        let cocktailInfo = CocktailPreviewForSingleCocktail(strDrink: strDrink, strDrinkThumb: strDrinkThumb, idDrink: idDrink, strInstructions: strInstructions)
        return cocktailInfo
    }
}
