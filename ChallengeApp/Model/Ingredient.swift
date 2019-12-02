//
//  Ingridient.swift
//  ChallengeApp
//
//  Created by Oriontek on 11/30/19.
//  Copyright © 2019 JoelsTeam. All rights reserved.
//

import Foundation

class Ingredient {
    var name: String = ""
    var measure: String = ""
    
    init(named: String, inMeasure: String) {
        self.name = named
        self.measure = inMeasure
    }
}
