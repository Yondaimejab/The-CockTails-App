//
//  UIView+Extension.swift
//  ChallengeApp
//
//  Created by Joel Alcantara on 7/12/23.
//  Copyright © 2023 JoelsTeam. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.masksToBounds = newValue > .zero
            layer.cornerRadius = newValue
        }
    }
}
