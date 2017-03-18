//
//  TodoListApplicationModel.swift
//  TodoList
//
//  Created by Gyuwon Yi on 3/12/17.
//  Copyright © 2017 Gyuwon. All rights reserved.
//

import Foundation

class ApplicationModel {
    
    let itemList: TodoItemListViewModel
    let newItemForm: NewTodoItemFormViewModel
    
    init(messageBox: MessageBox) {
        itemList = TodoItemListViewModel(messageBox: messageBox)
        newItemForm = NewTodoItemFormViewModel(itemList: itemList)
    }
    
}
