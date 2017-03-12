//
//  TodoListTests.swift
//  TodoListTests
//
//  Created by Gyuwon Yi on 3/11/17.
//  Copyright © 2017 Gyuwon. All rights reserved.
//

import XCTest
import RxSwift
@testable import TodoList

class TodoItemViewModel_specs: XCTestCase {
    
    func test_init_sets_description_correctly() {
        // Arrange
        let description: String = UUID().uuidString
        
        // Act
        let sut = TodoItemViewModel(description: description)
        
        // Assert
        XCTAssert(description == sut.description, "description was not set correctly.");
    }
    
    func test_init_sets_isComplete_to_false() {
        // Arrange
        
        // Act
        let sut = TodoItemViewModel(description: UUID().uuidString)
        
        // Assert
        XCTAssertFalse(sut.isComplete)
    }
    
    func test_description_setter_raises_propertyChanged_once() {
        // Arrange
        let sut = TodoItemViewModel(description: UUID().uuidString)
        var events = [String]()
        _ = sut.propertyChanged.subscribe(onNext: { propertyName in events.append(propertyName) })
        
        // Act
        sut.description = UUID().uuidString;
        
        // Assert
        XCTAssertEqual(1, events.count)
        XCTAssertEqual("description", events[0], "propertyChanged event for description is not raised.")
    }
    
    func test_isComplete_setter_raises_propertyChanged_once() {
        // Arrange
        let sut = TodoItemViewModel(description: "foo")
        var events = [String]()
        _ = sut.propertyChanged.subscribe(onNext: { propertyName in events.append(propertyName) })
        
        // Act
        sut.isComplete = true
        
        // Assert
        XCTAssertEqual(1, events.count)
        XCTAssertEqual("isComplete", events[0], "propertyChanged event for isComplete is not raised.")
    }
    
}
