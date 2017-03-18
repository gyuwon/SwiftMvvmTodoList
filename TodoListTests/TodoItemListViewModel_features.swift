//
//  TodoItemListViewModel_features.swift
//  TodoList
//
//  Created by Gyuwon Yi on 3/19/17.
//  Copyright © 2017 Gyuwon. All rights reserved.
//

import XCTest
@testable import TodoList

class TodoItemListViewModel_features: XCTestCase {

    func test_deleteItem_command_deletes_item_correctly() {
        // Arrange
        var data = [
            TodoItemViewModel(description: UUID().uuidString),
            TodoItemViewModel(description: UUID().uuidString),
            TodoItemViewModel(description: UUID().uuidString)
        ]
        let sut = TodoItemListViewModel(messageBox: StubMessageBox())
        for i in 0..<data.count {
            sut.items.append(item: data[i])
        }
        let index = Int(arc4random_uniform(UInt32(sut.items.count)))
        
        // Act
        sut.deleteItem.execute(parameter: index as AnyObject)
        
        // Assert
        data.remove(at: index)
        XCTAssertEqual(data.count, sut.items.count)
        for i in 0..<data.count {
            XCTAssertEqual(data[i].description, sut.items[i].description)
        }
    }
    
    func test_deleteItem_command_does_not_delete_item_if_not_confirmed() {
        // Arrange
        var data = [
            TodoItemViewModel(description: UUID().uuidString),
            TodoItemViewModel(description: UUID().uuidString),
            TodoItemViewModel(description: UUID().uuidString)
        ]
        let sut = TodoItemListViewModel(messageBox: StubMessageBox(confirm: false))
        for i in 0..<data.count {
            sut.items.append(item: data[i])
        }
        let index = Int(arc4random_uniform(UInt32(sut.items.count)))
        
        // Act
        sut.deleteItem.execute(parameter: index as AnyObject)
        
        // Assert
        XCTAssertEqual(data.count, sut.items.count)
        for i in 0..<data.count {
            XCTAssertEqual(data[i].description, sut.items[i].description)
        }
    }
}
