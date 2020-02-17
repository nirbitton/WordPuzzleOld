//
//  LetterCell.swift
//  GameWord
//
//  Created by Bitton, Nir on 20/11/2019.
//  Copyright © 2019 Bitton, Nir. All rights reserved.
//

import UIKit

class LetterCell: UICollectionViewCell {

    @IBOutlet weak var letter: UILabel!
    
    var strText = "ב"
    var IsSelected:Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        letter.text = strText
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
}
