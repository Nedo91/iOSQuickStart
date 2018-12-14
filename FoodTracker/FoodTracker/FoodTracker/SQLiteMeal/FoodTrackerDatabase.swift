import Foundation
import SQLite

class FoodTrackerDatabase {
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    let connection: Connection
    
    init() throws {
        connection = try Connection("\(path)/db.sqlite3")
        createTables()
    }
    
    func createTables() {
        let mealRepository = SQLiteMealRepository()
        let chefRepository = SQLChefRepository()
        do {
            try mealRepository.createMealTable(connection: self.connection)
            try chefRepository.createChefTable(connection: self.connection)
        } catch  {
            // silenced
        }
        
        
    }
}
