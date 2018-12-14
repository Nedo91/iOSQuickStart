//
//  SQLiteMealRepository.swift
//  FoodTracker
//
//  Created by Nedeljko Mijajlovic on 12/12/2018.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation
import SQLite

class SQLiteMealRepository {
    let id = Expression<Int64>("id")
    let name = Expression<String>("name")
    let rating = Expression<Int64>("rating")
    let meals = Table("meals")

    
    func createMealTable(connection: Connection) throws {
        
        try connection.run(meals.create { table in
            table.column(id, primaryKey: .autoincrement)
            table.column(rating)
            table.column(name)
        })
    }
    
     func getAllMeals(connection: Connection) -> [SQLiteMeal] {
      do {
            let rows = try connection.prepare(meals)
            var sqlArray = [SQLiteMeal]()
            for row in rows {
                let meal = mapToMeal(row: row)
                sqlArray.append(meal)
            }
            return sqlArray
        } catch {
          return []
        }
    }
    
    func addMeal(mealName: String, rating: Int64, connection: Connection) throws -> Int64 {
        return try connection.run(meals.insert(name <- mealName, self.rating <- rating))
    }
    
    func mapToMeal(row: Row) -> SQLiteMeal {
        return SQLiteMeal(id: row[id], name: row[name], photo: nil, rating: row[rating])
    }
    
    func removeMeal(connection: Connection, idToRemove: Int64) throws {
        let remove = meals.filter(id == idToRemove)
        try connection.run(remove.delete())
    }
}

