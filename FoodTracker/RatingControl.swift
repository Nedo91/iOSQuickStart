//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Nedeljko Mijajlovic on 04.11.2018.
//  Copyright © 2018 Nedeljko Mijajlovic. All rights reserved.
//

import UIKit

class RatingControl: UIStackView {
    //MARK: Initialization
    //MARK: Button Action
    
    @objc func ratingButtonTapped(button: UIButton) {
        print("Button pressed")
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
        
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
        
    }
    //MARK: Private Methods
    
    private func setupButtons() {
        
        let button = UIButton()
        button.backgroundColor = UIColor.red
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
        
        addArrangedSubview(button)
        
    }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */


