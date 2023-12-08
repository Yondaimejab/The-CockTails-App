//
//  CocktailsPreviewTableViewCell.swift
//  ChallengeApp
//
//  Created by Oriontek on 12/1/19.
//  Copyright © 2019 JoelsTeam. All rights reserved.
//

import UIKit

class CocktailsPreviewTableViewCell: UITableViewCell {

    @IBOutlet weak var cocktailImage: UIImageView!
    @IBOutlet weak var cocktailNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCellWith(name: String, image: UIImage) {
        cocktailNameLabel.text = name
        cocktailNameLabel.font = UIFont(name: "Jost-SemiBold", size: 20)
        cocktailNameLabel.textColor = ColorPalette.label
        self.cocktailImage.image = image
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
