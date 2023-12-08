//
//  ViewController.swift
//  ChallengeApp
//
//  Created by Oriontek on 11/30/19.
//  Copyright © 2019 JoelsTeam. All rights reserved.
//

import UIKit
import Lottie
import Anchorage
import Combine

class ViewController: UIViewController {

    var viewModel = PreviewCocktailsViewModel()
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var mainStackView: UIStackView!
    @IBOutlet var actionButton: UIButton!
    
    private var animationView: LottieAnimationView?
    private var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
        displayDefaultUI()
        subscribeToObservers()
        Task {
            await viewModel.requestCocktails()
        }
    }
    
    private func buildUI() {
        animationView = .init(name: "launchCocktail")
        if let animationView {
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .loop
            animationView.widthAnchor == 175
            animationView.heightAnchor == 175
            mainStackView.insertArrangedSubview(animationView, at: 1)
        }
    }
    
    private func displayDefaultUI() {
        welcomeLabel.textColor = ColorPalette.label
        welcomeLabel.font = UIFont(name: "Jost-Black", size: 40)
        subtitleLabel.textColor = ColorPalette.label
        subtitleLabel.font = UIFont(name: "Jost-Mediumitalic", size: 17)
        actionButton.isEnabled = viewModel.enableActionButton
        if #available(iOS 15.0, *) {
            var buttonConfig = actionButton.configuration
            buttonConfig?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = UIFont(name: "Jost-SemiBold", size: 15)
                return outgoing
            }
            actionButton.configuration = buttonConfig
        } else {
            actionButton.titleLabel?.font = UIFont(name: "Jost-Medium", size: 15)
        }
        
        animationView?.play()
    }
    
    private func subscribeToObservers() {
        cancellable = viewModel.$enableActionButton.receive(on: RunLoop.main)
            .sink { [weak self] enableActionButton in
            guard let self else { return }
            actionButton.isEnabled = enableActionButton
        }
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

