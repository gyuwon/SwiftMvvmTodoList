//
//  MessageBox.swift
//  TodoList
//
//  Created by Gyuwon Yi on 3/19/17.
//  Copyright © 2017 Gyuwon. All rights reserved.
//

import Foundation

protocol MessageBox {
    
    func confirm(title: String, message: String, confirmText: String, cancelText: String, destructive: Bool, confirmed: @escaping (Void) -> Void)

}
