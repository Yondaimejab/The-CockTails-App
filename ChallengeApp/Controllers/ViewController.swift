//
//  ViewController.swift
//  ChallengeApp
//
//  Created by Oriontek on 11/30/19.
//  Copyright © 2019 JoelsTeam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var viewModel = PreviewCoctailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.requestCocktails()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationController =  segue.destination as? UINavigationController {
            if let tableViewController = navigationController.viewControllers.first as? CocktailsTableViewController {
                tableViewController.cocktailsImages = viewModel.cocktailImages
                tableViewController.cocktails = viewModel.cocktailsPreviews
            }
        }
    }

}

