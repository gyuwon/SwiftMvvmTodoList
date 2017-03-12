//
//  TodoItemViewModel.swift
//  TodoList
//
//  Created by Gyuwon Yi on 3/12/17.
//  Copyright © 2017 Gyuwon. All rights reserved.
//

import Foundation
import RxSwift

class TodoItemViewModel {
    
    private let _propertyChanged = PublishSubject<String>()
    
    var description: String {
        didSet {
           _propertyChanged.onNext("description")
        }
    }
    
    var isComplete: Bool = false {
        didSet {
            _propertyChanged.onNext("isComplete")
        }
    }
    
    init(description: String) {
        self.description = description
    }
    
    var propertyChanged: Observable<String> { return _propertyChanged }

}
