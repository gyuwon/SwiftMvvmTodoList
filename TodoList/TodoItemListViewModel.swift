//
//  TodoListViewModel.swift
//  TodoList
//
//  Created by Gyuwon Yi on 3/12/17.
//  Copyright © 2017 Gyuwon. All rights reserved.
//

import Foundation

class TodoItemListViewModel {
    
    private let _messageBox: MessageBox
    private lazy var _deleteItem: RelayCommand = RelayCommand(execute: self.executeDeleteItem)

    let items = ObservableCollection<TodoItemViewModel>()
    
    init(messageBox: MessageBox) {
        _messageBox = messageBox
    }
    
    var deleteItem: RelayCommand { return _deleteItem }
    
    private func executeDeleteItem(parameter: Any?) {
        guard let index = parameter as? Int else { return }

        _messageBox.confirm(
            title: "Delete Todo Item?",
            message: "Description: \"" + items[index].description + "\"",
            confirmText: "Delete",
            cancelText: "Cancel",
            destructive: true,
            confirmed: { _ in self.items.remove(at: index)
        })
    }
    
}
