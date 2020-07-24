//
//  UIViewController+Util.swift
//  GameOfThroneCharacters
//
//  Created by Duc Dang on 7/24/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import UIKit

extension UIViewController {
    func showError(_ title: String?, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
    }
}
