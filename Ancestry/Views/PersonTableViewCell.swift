//
//  PersonTableViewCell.swift
//  Ancestry
//
//  Created by Eric Lanza on 5/27/19.
//  Copyright © 2019 ETLanza. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    var person: Person? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    
    func updateViews() {
        guard let person = person else { return }
        nameLabel.text = person.name
        sexLabel.text = person.sex
        birthLabel.text = "Born on \(person.birthInfo.date) in \(person.birthInfo.name)"
        if let death = person.deathInfo {
            deathLabel.isHidden = false
            deathLabel.text = "Died on \(death.date) in \(death.name)"
        } else {
            deathLabel.isHidden = true
        }
    }
}
