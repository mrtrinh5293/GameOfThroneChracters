//
//  DetailsViewController.swift
//  GameOfThroneCharacters
//
//  Created by Duc Dang on 7/21/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //        var characterDetails: Any?
    var characterName : Any?
    var houseName: Any?
    var nickname: Any?
    var actorName: Any?
    var actorLink : Any?
    
    @IBOutlet weak var charName: UILabel!
    
    @IBOutlet weak var actName: UILabel!
    
    @IBOutlet weak var nikname: UILabel!
    
    @IBOutlet weak var housName: UILabel!
    
    @IBOutlet weak var link: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        charName.text = characterName as Any as? String
        actName.text = actorName as Any as? String
        nikname.text = nickname as Any as? String
        housName.text = houseName as Any as? String
        link.text = actorLink as? String
    }

}

