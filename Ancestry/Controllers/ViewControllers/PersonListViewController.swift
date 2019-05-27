//
//  PeopleListViewController.swift
//  Ancestry
//
//  Created by Eric Lanza on 5/27/19.
//  Copyright © 2019 ETLanza. All rights reserved.
//

import UIKit

class PersonListViewController: UIViewController {
    
    let personController = PersonController()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        personController.fetchPeople { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let destionationVC = segue.destination as? PersonDetailViewController,
                let index = tableView.indexPathForSelectedRow else { return }
            let person = personController.people[index.row]
            destionationVC.person = person
        }
    }
}

// MARK: - Table View Data Source Methods
extension PersonListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personController.people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as? PersonTableViewCell
        
        let person = personController.people[indexPath.row]
        
        cell?.person = person
        
        if person.image == nil {
            personController.fetchImageFor(person: person) { (image) in
                DispatchQueue.main.async {
                    if image == nil {
                        person.image = #imageLiteral(resourceName: "missingPhoto")
                    } else {
                        person.image = image
                    }
                    cell?.personImageView.image = person.image
                }
            }
        } else {
            cell?.personImageView.image = person.image
        }
        
        return cell ?? UITableViewCell()
    }
    
    
}
