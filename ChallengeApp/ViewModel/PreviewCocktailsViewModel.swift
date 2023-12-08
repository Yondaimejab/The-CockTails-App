//
//  PreviewCoctailsViewModel.swift
//  ChallengeApp
//
//  Created by Oriontek on 12/1/19.
//  Copyright © 2019 JoelsTeam. All rights reserved.
//

import Foundation
import UIKit
import Combine

class PreviewCocktailsViewModel: BaseViewModel, ObservableObject {
    var cocktailsPreviews = [CocktailPreview]()
    var cocktailImages: [Int: UIImage] = [:]
    @Published var enableActionButton: Bool = false

    func requestCocktails() async {
        whileLoading()
        do {
            let route = CocktailsApiRoutes.getCocktails
            if let previews: CocktailsPreview = try await APIClient.service.fetchObject(route: route) {
                self.cocktailsPreviews = previews.drinks
                await self.downloadImages()
                enableActionButton = true
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getImageWith(id: Int) -> UIImage {
        return self.cocktailImages[id]!
    }
    
    private func downloadImages() async {
        Task {
            for item in cocktailsPreviews {
                await downloadImage(stringURL: item.strDrinkThumb, key: Int(item.idDrink)!)
            }
        }
    }

    private func downloadImage(stringURL: String, key: Int) async {
        guard let imageUrl = URL(string: stringURL) else { return }
        await withCheckedContinuation { continuation in
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                guard let data = try? Data(contentsOf: imageUrl) else {
                    return cocktailImages[key] = UIImage()
                }
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    let image = UIImage(data: data) ?? UIImage()
                    cocktailImages[key] = image
                    continuation.resume()
                }
            }
        }
    }
}
