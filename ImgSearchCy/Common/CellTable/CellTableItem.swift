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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
