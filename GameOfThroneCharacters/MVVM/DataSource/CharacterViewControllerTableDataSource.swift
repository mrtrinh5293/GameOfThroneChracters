//
//  CharacterViewControllerTableDataSource.swift
//  GameOfThroneCharacters
//
//  Created by Duc Dang on 7/24/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class CharacterViewControllerTableDataSource: NSObject,UICollectionViewDataSource {
    
    let characterCollectionViewModel : CharacterModel
    
    init(_ characterCollectionViewModel: CharacterModel) {
        self.characterCollectionViewModel = characterCollectionViewModel
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.characterCollectionViewModel.numberOfCharacters()
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
        
        let characterViewModel = self.characterCollectionViewModel.character(atIndex: indexPath.row)
        cell.displayCharacterDemo(characterViewModel)
        
        
        return cell
        
    }
}

extension CharacterViewControllerTableDataSource : UISearchBarDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchBar", for: indexPath)
        
        return searchView
    }
    
    
}
