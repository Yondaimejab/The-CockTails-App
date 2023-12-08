//
//  CocktailDetailsViewController.swift
//  ChallengeApp
//
//  Created by Oriontek on 12/1/19.
//  Copyright © 2019 JoelsTeam. All rights reserved.
//

import UIKit
import Anchorage
import Lottie

class CocktailDetailsViewController: UIViewController {
    
    @IBOutlet weak var cocktailImageView: UIImageView!
    @IBOutlet weak var IngredientsStackView: UIStackView!
    @IBOutlet weak var labelForInstructions: UILabel!
    @IBOutlet var animationView: LottieAnimationView!
    @IBOutlet var ingredientsSectionTitleLabel: UILabel!
    @IBOutlet var instructionSectionTitleLabel: UILabel!
    
    private var titleLabel = UILabel()
    private var titleView = UIView()
    var cocktailID: String!
    var viewModel = CocktailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
        displayDefaultUI()
        Task {
            if await viewModel.setCocktailWith(id: cocktailID) {
                populateViewsWithData()
            }
        }
    }
    
    private func buildUI() {
        titleView.addSubview(titleLabel)
        titleLabel.centerAnchors == titleView.centerAnchors
        titleLabel.heightAnchor <= titleView.heightAnchor
        if let animationStackView = animationView.superview as? UIStackView {
            animationView = .init(name: "launchCocktail")
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .playOnce
            animationView.widthAnchor == 175
            animationView.heightAnchor == 175
            animationStackView.addArrangedSubview(animationView)
        }
    }
    
    private func displayDefaultUI() {
        view.backgroundColor = ColorPalette.detailsBackground
        titleLabel.text = viewModel.getCocktailName()
        titleLabel.textColor = ColorPalette.label
        titleLabel.font = UIFont(name: "Jost-Medium", size: 32)
        [ingredientsSectionTitleLabel, instructionSectionTitleLabel].forEach { label in
            label.textColor = ColorPalette.label
            label.font = UIFont(name: "Jost-SemiBold", size: 24)
        }
        navigationItem.titleView = titleView
        labelForInstructions.textAlignment = .left
        labelForInstructions.font = UIFont(name: "Jost-Mediumitalic", size: 15)
        labelForInstructions.textColor = ColorPalette.label
        animationView.play(toProgress: 0.8)
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
    
    func populateViewsWithData() {
        cocktailImageView.image = viewModel.getCocktailImage()
        viewModel.getIngredients().forEach { ingredient in
            addToView(ingredient: ingredient)
        }
        labelForInstructions.text = viewModel.getInstructions()
    }
    
    private func addToView(ingredient: Ingredient) {
        let label = UILabel()
        label.text = ingredient.name + " ~> " + ingredient.measure
        label.textColor = ColorPalette.label
        label.font = UIFont(name: "Jost-Mediumitalic", size: 15)
        IngredientsStackView.addArrangedSubview(label)
    }
}
