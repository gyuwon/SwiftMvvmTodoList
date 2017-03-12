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
    private var _submit: RelayCommand? = nil
    
    init(itemList: TodoItemListViewModel) {
        _itemList = itemList
        _submit = RelayCommand(
            execute: executeSubmit,
            canExecute: canExecuteSubmit)
    }
    
    var propertyChanged: Observable<String> { return _propertyChanged }
    
    var description: String = "" {
        didSet {
            _propertyChanged.onNext("description")
            _submit!.raiseCanExecuteChanged()
        }
    }
    
    var submit: RelayCommand { return _submit! }
    
    private func executeSubmit() {
        _itemList.items.append(item: TodoItemViewModel(description: self.description))
        description = ""
    }
    
    private func canExecuteSubmit() -> Bool {
        return description != ""
    }
    
}
