//
//  TodoListApplicationModel.swift
//  TodoList
//
//  Created by Gyuwon Yi on 3/12/17.
//  Copyright © 2017 Gyuwon. All rights reserved.
//

import Foundation

class ApplicationModel {
    
    let newItemForm: NewTodoItemFormViewModel
    let itemList = TodoItemListViewModel()
    
    init() {
        newItemForm = NewTodoItemFormViewModel(itemList: itemList)
    }
    
}
