import Foundation
import SQLite

class SQLChefRepository {
    let id = Expression<Int64>("id")
    let name = Expression<String>("name")
    let age = Expression<Int64>("age")
    let workExp = Expression<Int64>("workExp")
    let chefs = Table("Chefs")
    
    
    func createChefTable(connection: Connection) throws {
        
        try connection.run(chefs.create { table in
            table.column(id, primaryKey: .autoincrement)
            table.column(age)
            table.column(name)
            table.column(workExp)
        })
    }
    
    func getAllChefs(connection: Connection) -> [SQLiteChefMeal] {
        do {
            let rows = try connection.prepare(chefs)
            var sqlArray = [SQLiteChefMeal]()
            for row in rows {
                let chef = mapToChef(row: row)
                sqlArray.append(chef)
            }
            return sqlArray
        } catch {
            return []
        }
    }
    
    func addChef(chefName: String, age: Int64, workExp: Int64, connection: Connection) throws -> Int64 {
        return try connection.run(chefs.insert(name <- chefName, self.age <- age, self.workExp <- workExp))
    }
    
    func mapToChef(row: Row) -> SQLiteChefMeal {
        return SQLiteChefMeal(id: row[id], name: row[name], age: row[age], workExp: row[workExp])
    }
    
    func removeChef(connection: Connection, idToRemove: Int64) throws {
        let remove = chefs.filter(id == idToRemove)
        try connection.run(remove.delete())
    }
}
