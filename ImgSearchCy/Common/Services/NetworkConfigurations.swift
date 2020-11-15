//
//  NetworkConfigurations.swift
//  WeatherCy
//
//  Created by Lucy on 21/08/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import Foundation


struct NetworkConfigurations {
    
    fileprivate static let DevBaseUrl = "https://developers.zomato.com/api/v2.1/"
    fileprivate static let ProdBaseUrl = "https://developers.zomato.com/api/v2.1/"
    
    fileprivate static let kClientSecret = ""
    static let APIKeyZomato = "708732356cff30af9e5ba3cd87ecaae8"
    fileprivate static let IDCity = "52" // sg
    fileprivate static let IDRes = "18483222"
    //properBaseUrl will be lazy load and called only once on first access
    static var properBaseUrl: String = {
        #if DEBUG
        return DevBaseUrl
        #else
        return ProdBaseUrl
        #endif
    }()
    
    static func parseCurrentUrlHost() -> String {
        let currentBaseUrl = URL(string: properBaseUrl)!
        return currentBaseUrl.host!
    }
    
}
