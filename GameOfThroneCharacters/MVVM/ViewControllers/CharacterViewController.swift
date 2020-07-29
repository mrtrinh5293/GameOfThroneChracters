//
//  ViewController.swift
//  GameOfThroneCharacters
//
//  Created by Duc Dang on 7/21/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import UIKit
import CoreData

class CharacterViewController: UIViewController {
    
    @IBOutlet weak public var collectionView: UICollectionView!
    
    @IBOutlet weak var fetchButLabel: UIButton!
    var characterModel: CharacterModel!
    var characterArray = [Character]()
    var context = CoreDataStorage.shared.managedObjectContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.characterModel = CharacterModel(self)
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.characterModel.getCharacter()
        
    }
}

extension CharacterViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func loadCharacters(with request: NSFetchRequest<Character> = Character.fetchRequest()) {
        
        do {
            characterArray = try context.fetch(request)
        } catch {
            print("error loading data")
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.alpha = 0
        return self.characterModel.passCharacterData().count
    }
    
    @IBAction func fetchData(_ sender: Any) {
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            [weak self] in
            self?.collectionView.alpha = 1
            
        })
        fetchButLabel.alpha = 0
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
        cell.layer.masksToBounds = false
        
        //        let characterViewModel = self.characterModel.testChar()[indexPath.row]
        let characterViewModel = self.characterModel.character(atIndex: indexPath.row)
        
        cell.displayCharacterDemo(characterViewModel)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "gotoDetail", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let dest = segue.destination as? DetailsViewController, let index = collectionView.indexPathsForSelectedItems?.first {
            dest.characterName = characterModel.character(atIndex: index.row).characterName
            
            dest.nickname = characterModel.character(atIndex: index.row).nickname
            
            dest.actorName = characterModel.character(atIndex: index.row).actorName
            
            dest.actorLink = characterModel.character(atIndex: index.row).actorLink
            
            dest.houseName = characterModel.character(atIndex: index.row).houseName
        }
    }
}

extension CharacterViewController: UISearchBarDelegate {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchBar", for: indexPath)
        
        return searchView
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Character> = Character.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadCharacters(with: request)
        
        collectionView.reloadData()
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadItems()
//            
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//            
//        }
//    }
}


extension CharacterViewController: CharacterModelProtocol {
    
    func parseCharactersSuccess() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func parseCharactersFailedWithMessage(_ message: String) {
        self.showError(nil, message: message)
    }
    
}

