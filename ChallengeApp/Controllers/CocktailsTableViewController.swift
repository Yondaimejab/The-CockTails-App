//
//  CocktailsTableViewController.swift
//  ChallengeApp
//
//  Created by Oriontek on 12/1/19.
//  Copyright © 2019 JoelsTeam. All rights reserved.
//

import UIKit

class CocktailsTableViewController: UITableViewController {
    
    @IBOutlet var cocktailsTableView: UITableView!
    var cocktails: [CocktailPreview]!
    var cocktailsImages: [Int:UIImage]!
    let tableViewCellIdentifier = "coctailsTableViewCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CocktailsPreviewTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: tableViewCellIdentifier)
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
        let coctailImage: UIImage = {
            if let image = cocktailsImages[Int(cocktail.idDrink)!] {
                return image
            }else {
                return UIImage()
            }
        }()
        cell.setupCellWith(
            name: cocktail.strDrink,
            image: coctailImage)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CocktailDetailsViewController {
            destination.cocktailID = self.cocktails[self.tableView.indexPathForSelectedRow!.row].idDrink
            destination.navigationController?.title  = self.cocktails[self.tableView.indexPathForSelectedRow!.row].strDrink
        }
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
