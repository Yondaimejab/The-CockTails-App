//
//  CocktailsTableViewController.swift
//  ChallengeApp
//
//  Created by Oriontek on 12/1/19.
//  Copyright © 2019 JoelsTeam. All rights reserved.
//

import UIKit
import Anchorage

class CocktailsTableViewController: UITableViewController {
    
    @IBOutlet var cocktailsTableView: UITableView!
    var cocktails: [CocktailPreview]!
    var cocktailsImages: [Int:UIImage]!
    let tableViewCellIdentifier = "coctailsTableViewCellIdentifier"
    
    private var titleLabel = UILabel()
    private var titleView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CocktailsPreviewTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: tableViewCellIdentifier)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        buildUI()
        displayDefaultUI()
    }

    private func buildUI() {
        titleView.addSubview(titleLabel)
        titleLabel.centerAnchors == titleView.centerAnchors
        titleLabel.heightAnchor <= titleView.heightAnchor
    }
    
    private func displayDefaultUI() {
        titleLabel.text = navigationItem.title
        titleLabel.textColor = ColorPalette.label
        titleLabel.font = UIFont(name: "Jost-Medium", size: 32)
        navigationItem.titleView = titleView
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktails.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toCocktailDetailsController", sender: self)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as! CocktailsPreviewTableViewCell
        let cocktail = cocktails[indexPath.row]
        let cocktailImage: UIImage = {
            guard let image = cocktailsImages[Int(cocktail.idDrink)!] else { return UIImage() }
            return image
        }()
        cell.setupCellWith(name: cocktail.strDrink, image: cocktailImage )
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CocktailDetailsViewController {
            destination.cocktailID = self.cocktails[self.tableView.indexPathForSelectedRow!.row].idDrink
            let title = cocktails[self.tableView.indexPathForSelectedRow!.row].strDrink.capitalized
            destination.navigationController?.title = title
        }
    }

}
