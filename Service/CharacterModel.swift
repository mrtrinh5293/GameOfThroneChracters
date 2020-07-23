//
//  CharacterModel.swift
//  GameOfThroneCharacters
//
//  Created by Duc Dang on 7/21/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import Foundation
import CoreData

protocol CharacterModelProtocol {
    func charactersRetrieved(_ characters:[Character])
}

class CharacterModel {
    
    var delegate: CharacterModelProtocol?
    
    func getCharacter() {
        let stringUrl = "https://api.jsonbin.io/b/5f15de09c1edc466175ad86c/9"
            
            // Create url object
            let url = URL(string: stringUrl)
            
            // check that it isnt nil
            guard url != nil else {
                print("Could not get the url object")
                return
            }
            
            let session = URLSession.shared
            // create data task
            let dataTask = session.dataTask(with: url!) { (data, response, error) in
                if error == nil && data != nil {
                    let decoder = JSONDecoder()
                    do {
                        // Parse the json into ArticlesService
                        let characterService = try decoder.decode(CharacterService.self, from: data!)
                        
                        
                        // Get the article
                        let characters = characterService.characters!
                        
                        // Pass the article to the view controller in the main thread
                        DispatchQueue.main.async {
                            self.delegate?.charactersRetrieved(characters)
                        
                        }
                    } catch {
                        print("Could not parse JSon")
                    }
                }
            }
            // start the data task
            dataTask.resume()
            
            // Parse the returned JSON into article instances and pass it back the the view controller with the protocol and delegate pattern
        }
    }
    
