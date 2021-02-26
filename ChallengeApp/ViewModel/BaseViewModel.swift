//
//  BaseViewModel.swift
//  ChallengeApp
//
//  Created by Oriontek on 11/30/19.
//  Copyright © 2019 JoelsTeam. All rights reserved.
//

import Foundation

class BaseViewModel {
   var whileLoading: (() -> Void) = { }
   var whenLoaded: (() -> Void) = { }
   var whenLoadedWithParameters: ((Any,[String:Any?]) -> Void) = { (_,_) in }
   var onError: ((String) -> Void) = { _ in }
}
