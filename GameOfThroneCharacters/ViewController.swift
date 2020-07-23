//
//  ViewController.swift
//  GameOfThroneCharacters
//
//  Created by Duc Dang on 7/21/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
//    let context = UIApplication.shared.delegate as!
    var model = CharacterModel()
    var characters = [Character]()
    
    private var searchData: [Character]! = []
    private var savedData: [Character]! = []

    // Core Data proprety
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        model.delegate = self
        model.getCharacter()

    }
}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as! CharacterCollectionViewCell
        
        
        //Add shadow for cell
        cell.layer.cornerRadius = 15.0
        cell.layer.borderWidth = 0.0
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 8.0
        cell.layer.shadowOpacity = 1
        cell.layer.masksToBounds = false //<-
        
        let character = characters[indexPath.row]
        
        cell.displayCharacterDemo(character)
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "gotoDetail", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let dest = segue.destination as? DetailsViewController, let index = collectionView.indexPathsForSelectedItems?.first {
            
            dest.characterName = characters[index.row].characterName as Any
            
            dest.nickname = characters[index.row].nickname ?? "Character has no Nickname" as Any 
            
            dest.actorName = characters[index.row].actorName as Any
            dest.houseName = characters[index.row].houseName as Any
            dest.actorLink =  characters[index.row].actorLink
        }
    }
    
}


extension ViewController : UISearchBarDelegate {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchBar", for: indexPath)
        return searchView
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchData.removeAll()
        
        for item in self.savedData {
            if (item.characterName?.lowercased().contains(searchBar.text!.lowercased()))! {
                self.searchData.append(item)
                self.characters = self.searchData
            } else if(searchBar.text!.isEmpty) {
                self.characters  = self.savedData
            }
        }
        
        self.collectionView.reloadData()
    }
    
}


extension ViewController: CharacterModelProtocol {
    func charactersRetrieved(_ characters: [Character]) {
        self.characters = characters

        // make a copy of data and assign it to savedData
        self.savedData = characters
        
        collectionView.reloadData()
    }
}



