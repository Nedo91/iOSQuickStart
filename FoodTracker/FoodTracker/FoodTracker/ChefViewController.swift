//
//  ChefViewController.swift
//  FoodTracker
//
//  Created by Nedeljko Mijajlovic on 13/12/2018.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit
import os.log



class ChefViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var nameChefText: UITextField!
    @IBOutlet weak var ageChefText: UITextField!
    @IBOutlet weak var workExpChefText: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    

    var chef: SQLiteChefMeal?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameChefText.delegate = self
        ageChefText.delegate = self
        workExpChefText.delegate = self
        
        if let chef = chef {
            navigationItem.title = chef.name
            nameChefText.text = chef.name
            ageChefText.text = String(chef.age)
            workExpChefText.text = String(chef.workExp)
        }
        
        updateSaveButtonState()
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
    
        dismiss(animated: true, completion: nil)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameChefText.text ?? ""
        let age = ageChefText.text ?? ""
        let workExp = workExpChefText.text ?? ""
        
        chef = SQLiteChefMeal(id: nil, name: name, age: Int64(age)!, workExp: Int64(workExp)!)
    }
    
    private func updateSaveButtonState() {
        
        let text = nameChefText.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}

	
