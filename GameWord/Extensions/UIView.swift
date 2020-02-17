//
//  UIView.swift
//  GameWord
//
//  Created by Bitton, Nir on 07/12/2019.
//  Copyright © 2019 Bitton, Nir. All rights reserved.
//

import UIKit

extension UIView {

    func cornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
