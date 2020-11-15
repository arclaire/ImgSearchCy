//
//  IListHeroes.swift
//  ImgSearchCy
//
//  Created by Lucy on 20/09/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import UIKit

class IListMenu: BaseViewModel {
    var dataManager : ManagerMenu?
   
    var model: [ModelFood]?
    
    init(manager: ManagerMenu) {
        self.dataManager = manager
       
    }
        
    func fetchResto() -> Observable<[ModelResto]?> {
        //entity_id=52&entity_type=city
        let url = NetworkConfigurations.properBaseUrl + "search?"
    
        let paramBody: [String: Any] = ["entity_id" : 52, "entity_type" : "city"]
        
        return NetworkProvider().get(url, params: paramBody).map { response in
            
            if let data = response as? [AnyHashable: Any] {           
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data["restaurants"] as Any, options: [])
                    //print("RESPON", data["restaurants"], "JSONDATA", jsonData)
                    let decode = try JSONDecoder().decode([ModelResto].self, from: jsonData)
                    return decode
                } catch let error {
                    print(error)
                }
            }
            
            return nil
        }
    }
   
    func filterModelWith(str: String) -> [ModelFood] {
        var arr = [ModelFood]()
  
        if let data = self.model {
            arr = data.filter {
                ($0.cuisines?.lowercased().contains(str.lowercased()))!
            }
        }
        return arr
    }
    
  
    

}
