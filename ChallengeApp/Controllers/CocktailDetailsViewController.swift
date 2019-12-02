//
//  CocktailDetailsViewController.swift
//  ChallengeApp
//
//  Created by Oriontek on 12/1/19.
//  Copyright © 2019 JoelsTeam. All rights reserved.
//

import UIKit

class CocktailDetailsViewController: UIViewController {
    
    @IBOutlet weak var cocktailImageView: UIImageView!
    @IBOutlet weak var labelForCocktailName: UILabel!
    @IBOutlet weak var IngredientsStackView: UIStackView!
    @IBOutlet weak var labelForInstructions: UILabel!
    var cocktailID: String!
    var viewModel = CocktailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.setCocktailWith(id: cocktailID) { setpDetails in
            if setpDetails {
                self.setupViews()
            }
        }
        roundImageView()
        // Do any additional setup after loading the view.
    }
    
    func roundImageView(){
        self.cocktailImageView.layer.borderWidth = 1
        self.cocktailImageView.layer.masksToBounds = false
        self.cocktailImageView.layer.borderColor = UIColor.black.cgColor
        self.cocktailImageView.layer.cornerRadius = 15.0
        self.cocktailImageView.clipsToBounds = true
    }
    
    func stylingStackView(){
        self.IngredientsStackView.backgroundColor = .gray
        self.IngredientsStackView.layer.cornerRadius = 15.0
        self.cocktailImageView.clipsToBounds = true
    }
    
    func setupViews(){
        labelForCocktailName.text = viewModel.getCocktailName()
        cocktailImageView.image = viewModel.getCoctailImage()
        for ingredients in viewModel.getIngredients() {
            let label = UILabel()
            label.text = ingredients.name + " ~> " + ingredients.measure
            IngredientsStackView.addArrangedSubview(label)
        }
        labelForInstructions.text = viewModel.getInstructions()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
