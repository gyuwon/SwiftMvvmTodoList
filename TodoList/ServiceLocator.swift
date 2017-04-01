//
//  ServiceLocator.swift
//  TodoList
//
//  Created by Gyuwon Yi on 3/19/17.
//  Copyright © 2017 Gyuwon. All rights reserved.
//

import Foundation
import UIKit

class UIAlertMessageBox: MessageBox {
    
    var currentViewController: UIViewController? = nil

    func confirm(title: String, message: String, confirmText: String, cancelText: String, destructive: Bool, confirmed: @escaping (Void) -> Void) {
        guard let currentViewController = currentViewController else { return }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancelText, style: .default))
        alert.addAction(UIAlertAction(title: confirmText, style: destructive ? .destructive : .default) { (action) -> Void in
            confirmed()
        })
        currentViewController.present(alert, animated: true, completion: nil)
    }

}

struct ServiceLocator {
    
    static var messageBox = UIAlertMessageBox()

}
