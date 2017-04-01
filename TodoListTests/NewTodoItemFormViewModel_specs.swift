//
//  NewTodoItemFormViewModel_specs.swift
//  TodoList
//
//  Created by Gyuwon Yi on 3/12/17.
//  Copyright © 2017 Gyuwon. All rights reserved.
//

import XCTest
import RxSwift
@testable import TodoList

class NewTodoItemFormViewModel_specs: XCTestCase {
    
    func test_description_setter_raises_propertyChanged_correctly() {
        // Arrange
        let sut = NewTodoItemFormViewModel(itemList: TodoItemListViewModel(messageBox: StubMessageBox()))
        var events = [String]()
        _ = sut.propertyChanged.subscribe(onNext: { event in events.append(event) })
        
        // Act
        sut.description = "foo"
        
        // Assert
        XCTAssertEqual(1, events.count)
        XCTAssertEqual("description", events[0])
    }
    
    func test_submit_adds_new_item_to_list() {
        // Arrange
        let itemList = TodoItemListViewModel(messageBox: StubMessageBox())
        let sut = NewTodoItemFormViewModel(itemList: itemList)
        let description: String = UUID().uuidString
        sut.description = description
        
        // Act
        sut.submit.execute()
        
        // Assert
        XCTAssertEqual(1, itemList.items.count)
        XCTAssertEqual(description, itemList.items[0].description)
    }
    
    func test_submit_clears_description_field() {
        // Arrange
        let sut = NewTodoItemFormViewModel(itemList: TodoItemListViewModel(messageBox: StubMessageBox()))
        sut.description = UUID().uuidString
        
        // Act
        sut.submit.execute()
        
        // Assert
        XCTAssertEqual("", sut.description)
    }
    
    func test_cannot_execute_submit_if_description_is_empty() {
        // Arrange
        let sut = NewTodoItemFormViewModel(itemList: TodoItemListViewModel(messageBox: StubMessageBox()))
        sut.description = ""
        
        // Act
        let actual: Bool = sut.submit.canExecute()
        
        // Assert
        XCTAssertEqual(false, actual)
    }
    
    func test_description_setter_raises_canExecuteChanged_of_submit_command() {
        // Arrange
        let sut = NewTodoItemFormViewModel(itemList: TodoItemListViewModel(messageBox: StubMessageBox()))
        var monitor: Int = 0
        _ = sut.submit.canExecuteChanged.subscribe(onNext: { monitor = monitor + 1 })
        
        // Act
        sut.description = UUID().uuidString
        
        // Assert
        XCTAssertEqual(1, monitor)
    }
    
}
