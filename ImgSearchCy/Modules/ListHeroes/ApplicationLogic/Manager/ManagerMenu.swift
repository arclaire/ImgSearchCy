//
//  ManagerHeroes.swift
//  ImgSearchCy
//
//  Created by Lucy on 20/09/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import Foundation
import CoreData

class ManagerMenu {
    let arrCuisine: [String] = ["Singaporean", "American", "Indian"]
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveFoodies(_ foods: [ModelFood]) {
        for food in foods {
            let foodies = NSEntityDescription.insertNewObject(forEntityName: "Food", into: self.context)
            foodies.setValue(food.id, forKey: "id")
            foodies.setValue(food.name, forKey: "name")
            foodies.setValue(food.currency, forKey: "currency")
            foodies.setValue(food.average_cost_for_two, forKey: "average_cost_for_two")
            foodies.setValue(food.thumb, forKey: "thumb")
            foodies.setValue(food.featured_image, forKey: "featured_image")
            foodies.setValue(food.cuisines, forKey: "cuisines")
        }
        do {
            try context.save()
            print("Success")
        } catch {
            print("Error saving: \(error)")
        }
    }
    
    func retrieveFood () -> [ModelFood]{
        let request: NSFetchRequest <Food> = Food.fetchRequest()
        var arrModel: [ModelFood] = [ModelFood]()
        do {
           let foods = try context.fetch(request)
            for food in foods {
                let modelFood = ModelFood()
                if let str = food.value(forKey: "id") as? String {
                    modelFood.id = str
                }
                if let str = food.value(forKey: "name") as? String {
                    modelFood.name = str
                }
                
                if let str = food.value(forKey: "currency") as? String {
                    modelFood.currency = str
                }
                
                if let str = food.value(forKey: "featured_image") as? String {
                    modelFood.featured_image = str
                }
                
                if let str = food.value(forKey: "thumb") as? String {
                    modelFood.thumb = str
                }
                
                if let str = food.value(forKey: "cuisines") as? String {
                    modelFood.cuisines = str
                }
                
                if let str = food.value(forKey: "average_cost_for_two") as? Double {
                    modelFood.average_cost_for_two = str
                }
                
              
                arrModel.append(modelFood)
            }
        } catch {
            print("error:\(error)")
        }
        return arrModel
    }
}
