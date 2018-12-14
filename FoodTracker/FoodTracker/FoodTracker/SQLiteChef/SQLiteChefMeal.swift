import Foundation
import UIKit
import SQLite

class SQLiteChefMeal {
    var id: Int64!
    var name: String!
    var age: Int64
    var workExp: Int64
    
    init(id: Int64!, name: String, age: Int64, workExp: Int64) {
        self.id = id
        self.name = name
        self.age = age
        self.workExp = workExp
    }
}
