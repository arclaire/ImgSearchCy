//
//  VCListHeroesDetail.swift
//  ImgSearchCy
//
//  Created by Lucy on 21/09/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import UIKit
////type(melees or range),
//- attribute(agi, str, int)
//- health
//- max attack
//- speed
//- roles
class VCListHeroesDetail: UIViewController {
    @IBOutlet weak var labelStr: UILabel!
    @IBOutlet weak var labelSpd: UILabel!
    @IBOutlet weak var labelHp: UILabel!
    @IBOutlet weak var labelDef: UILabel!
    @IBOutlet weak var labelAgi: UILabel!
    @IBOutlet weak var labelInt: UILabel!
    @IBOutlet weak var labelRoles: UILabel!
    @IBOutlet weak var labelAtk: UILabel!
    @IBOutlet weak var labelArmor: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionview: UICollectionView!
    var eventHandler : PsListHeroesDetail?
    var model: ModelFood? {
        didSet {
           
        }
    }
    var modelSimilar: [ModelFood]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setDataToUI()
       
        // Do any additional setup after loading the view.
    }
    

    private func setDataToUI() {
        if let data = self.model {
           
           
           
        }
    }
}


