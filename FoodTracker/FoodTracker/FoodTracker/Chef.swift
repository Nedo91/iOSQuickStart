import UIKit
import os.log


class Chef: NSObject, NSCoding {
    
    //MARK: Properties
    var id: String
    var name: String
    var age: Int64
    var workExp: Int64
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("chefs")
    
    //MARK: Types
    
    struct PropertyKey {
        static let id = "id"
        static let name = "name"
        static let age = "age"
        static let workExp = "workExp"
    }
    
    //MARK: Initialization
    
    init?(id: String,name: String, age: Int64, workExp: Int64) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (age >= 0) && (age <= 100) else {
            return nil
        }
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || age < 0  {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.age = age
        self.workExp = workExp
        self.id = id
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(age, forKey: PropertyKey.age)
        aCoder.encode(workExp, forKey: PropertyKey.workExp)
        aCoder.encode(id, forKey: PropertyKey.id)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let age = aDecoder.decodeObject(forKey: PropertyKey.age) as? Int64
        
        let workExp = aDecoder.decodeInteger(forKey: PropertyKey.workExp)
        
        // Must call designated initializer.
        self.init(id: id,name: name, age: age!, workExp: Int64(workExp))
        
    }
}


