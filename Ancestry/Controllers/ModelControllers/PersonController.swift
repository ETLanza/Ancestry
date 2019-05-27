//
//  PersonController.swift
//  Ancestry
//
//  Created by Eric Lanza on 5/27/19.
//  Copyright © 2019 ETLanza. All rights reserved.
//

import UIKit

class PersonController {
    
    var people: [Person] = []
    
    func fetchPeople(completion: @escaping (Bool) -> Void) {
        if let path = Bundle.main.path(forResource: "person", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let peopleJSON = try JSONDecoder().decode(TopLevelPersonJSON.self, from: data)
                self.people = peopleJSON.people
                completion(true)
            } catch {
                completion(false)
                fatalError("JSON Data not decoded properly: \(error) : \(error.localizedDescription))")
            }
        }
    }
    
    func fetchImageFor(person: Person, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: person.portraitURL) { (data, response, error) in
            if let error = error {
                print("Error fetching image for \(person) : \(error) : \(error.localizedDescription)")
                completion(nil)
                return
            }
            
//            if let response = response {
//                print(response)
//            }
            
            guard let data = data, let image = UIImage(data: data) else { completion(nil); return }
            
            completion(image)
        }.resume()
    }
}
