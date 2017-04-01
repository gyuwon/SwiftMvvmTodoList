//
//  NewTodoItemViewModel.swift
//  TodoList
//
//  Created by Gyuwon Yi on 3/12/17.
//  Copyright © 2017 Gyuwon. All rights reserved.
//

import Foundation
import RxSwift

class NewTodoItemFormViewModel {
    
    private let _propertyChanged = PublishSubject<String>()
    private let _itemList: TodoItemListViewModel
    private lazy var _submit: RelayCommand = RelayCommand(
        execute: self.executeSubmit,
        canExecute: self.canExecuteSubmit)

    init(itemList: TodoItemListViewModel) {
        _itemList = itemList
    }
    
    var propertyChanged: Observable<String> { return _propertyChanged }
    
    var description: String = "" {
        didSet {
            _propertyChanged.onNext("description")
            _submit.raiseCanExecuteChanged()
        }
    }
    
    var submit: RelayCommand { return _submit }
    
    private func executeSubmit(parameter: Any?) {
        _itemList.items.append(item: TodoItemViewModel(description: self.description))
        description = ""
    }
    
    private func canExecuteSubmit(parameter: Any?) -> Bool {
        return description != ""
    }
    
}
