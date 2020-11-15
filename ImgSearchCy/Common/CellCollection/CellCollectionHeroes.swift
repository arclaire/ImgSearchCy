//
//  CellCollectionHeroes.swift
//  ImgSearchCy
//
//  Created by Lucy on 21/09/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import UIKit

class CellCollectionHeroes: UICollectionViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setDataToUI(model: String, hideTitle: Bool = false) {
        
        if !hideTitle {
            self.labelTitle.text = model
            
        } else {
            if model.count > 1 {
                self.img.setImage(model)
            } else {
                self.img.setImage("https://reviewit.pk/wp-content/uploads/2019/10/img_4307.jpg")
            }
        }
        
        self.labelTitle.isHidden = hideTitle
        self.img.isHidden = !hideTitle
    }
    
    
}
