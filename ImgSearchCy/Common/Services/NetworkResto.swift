//
//  NetworkHeroes.swift
//  ImgSearchCy
//
//  Created by Lucy on 19/09/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import UIKit

class NetworkResto: NSObject {
    class func fetchResto() -> Observable<[ModelResto]?> {
        //entity_id=52&entity_type=city
        let url = NetworkConfigurations.properBaseUrl + "search?"
        let paramHeader: [String: Any] = ["user-key": NetworkConfigurations.APIKeyZomato]
        let paramBody: [String: Any] = ["entity_id" : 52, "entity_type" : "city"]
        
        return NetworkProvider().get(url, params: paramHeader, bodyParams: paramBody).map { response in
            
            if let data = response as? [AnyHashable: Any] {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                    let decode = try JSONDecoder().decode([ModelResto].self, from: jsonData)
                    return decode
                } catch let error {
                    print(error)
                }
            }
            
            return nil
        }
    }
}
