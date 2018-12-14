import Foundation
import UIKit
import SQLite

class SQLiteMeal {
    var id: Int64!
    var name: String!
    var photo: UIImage?  // wiek
    var rating: Int64 = 0 // staż pracy
    
    init(id: Int64!, name: String, photo: UIImage? = nil, rating: Int64 = 0) {
        self.id = id
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
