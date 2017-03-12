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
    
    public private(set) var description: String {
        didSet {
           _propertyChanged.onNext("description")
        }
    }
    
    public private(set) var isComplete: Bool = false {
        didSet {
            _propertyChanged.onNext("isComplete")
        }
    }
    
    init(description: String) {
        self.description = description
    }
    
    var propertyChanged: Observable<String> { return _propertyChanged }
    
    func updateDescription(description: String) {
        self.description = description
    }
    
    func markAsComplete() {
        isComplete = true
    }
    
    func markAsIncomplete() {
        isComplete = false
    }

}
