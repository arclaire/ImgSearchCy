//
//  IListHeroesDetail.swift
//  ImgSearchCy
//
//  Created by Lucy on 21/09/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import UIKit

class IListHeroesDetail: NSObject {
    var dataManager : ManagerMenu?
   
    var model: [ModelFood]?
    var modelSelected: ModelFood = ModelFood()
    
    init(manager: ManagerMenu) {
        self.dataManager = manager
       
    }
    
    
}
