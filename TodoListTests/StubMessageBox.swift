//
//  StubMessageBox.swift
//  TodoList
//
//  Created by Gyuwon Yi on 3/19/17.
//  Copyright © 2017 Gyuwon. All rights reserved.
//

import Foundation
@testable import TodoList

class StubMessageBox: MessageBox {
    
    private let _confirm: Bool
    
    init() {
        _confirm = true
    }
    
    init(confirm: Bool) {
        _confirm = confirm
    }
    
    func confirm(title: String, message: String, confirmText: String, cancelText: String, destructive: Bool, confirmed: @escaping (Void) -> Void) {
        if _confirm {
            confirmed()
        }
    }
    
}
