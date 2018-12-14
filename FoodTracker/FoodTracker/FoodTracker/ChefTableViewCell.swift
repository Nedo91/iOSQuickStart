//
//  ChefTableView.swift
//  FoodTracker
//
//  Created by Nedeljko Mijajlovic on 13/12/2018.
//  Copyright © 2018 Apple Inc. All rights reserved.
//


import UIKit

class ChefTableViewCell: UITableViewCell {
    

    @IBOutlet weak var Age: UILabel!
    @IBOutlet weak var workExp: UILabel!
    @IBOutlet weak var Name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
