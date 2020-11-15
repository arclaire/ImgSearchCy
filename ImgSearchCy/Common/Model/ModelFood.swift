//
//  ModelHeroes.swift
//  ImgSearchCy
//
//  Created by Lucy on 19/09/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import Foundation

class ModelResto: Codable {
    var restaurant: ModelFood?
}

class ModelRestaurant: Codable {
    var restaurant: ModelFood?
}

class ModelFood: Codable {
    var id: String?
    var name: String?
    var featured_image: String?
    var currency: String?
    var thumb: String?
    var cuisines: String?
    var average_cost_for_two: Double?
   
}
