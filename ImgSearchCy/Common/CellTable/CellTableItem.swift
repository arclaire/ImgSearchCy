//
//  CellTableItem.swift
//  ImgSearchCy
//
//  Created by Lucy on 16/11/20.
//

import UIKit

class CellTableItem: UITableViewCell {

    @IBOutlet weak var imgThumb: UIImageView!
    @IBOutlet weak var buttonPrice: UIButton!
    @IBOutlet weak var labelName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgThumb.layer.cornerRadius = 5
        self.buttonPrice.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
