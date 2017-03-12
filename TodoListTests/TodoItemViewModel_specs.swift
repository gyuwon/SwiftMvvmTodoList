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
    
    func test_updateDescription_sets_description_correctly() {
        // Arrange
        let sut = TodoItemViewModel(description: UUID().uuidString)
        let description: String = UUID().uuidString
        
        // Act
        sut.updateDescription(description: description)
        
        // Assert
        XCTAssert(description == sut.description, "description was not set correctly.");
    }
    
    func test_updateDescription_raises_propertyChanged_once() {
        // Arrange
        let sut = TodoItemViewModel(description: UUID().uuidString)
        var events = [String]()
        _ = sut.propertyChanged.subscribe(onNext: { propertyName in events.append(propertyName) })
        
        // Act
        sut.updateDescription(description: UUID().uuidString);
        
        // Assert
        XCTAssertEqual(1, events.count)
        XCTAssertEqual("description", events[0], "propertyChanged event for description is not raised.")
    }
    
    func test_markAsComplete_sets_isComplete_to_true() {
        // Arrange
        let sut = TodoItemViewModel(description: "foo")
        
        // Act
        sut.markAsComplete()
        
        // Assert
        XCTAssertEqual(true, sut.isComplete)
    }
    
    func test_markAsComplete_raises_propertyChanged_once() {
        // Arrange
        let sut = TodoItemViewModel(description: "foo")
        var events = [String]()
        _ = sut.propertyChanged.subscribe(onNext: { propertyName in events.append(propertyName) })
        
        // Act
        sut.markAsComplete()
        
        // Assert
        XCTAssertEqual(1, events.count)
        XCTAssertEqual("isComplete", events[0], "propertyChanged event for isComplete is not raised.")
    }
    
    func test_markAsIncomplete_sets_isComplete_to_false() {
        // Arrange
        let sut = TodoItemViewModel(description: "foo")
        sut.markAsComplete()
        
        // Act
        sut.markAsIncomplete()
        
        // Assert
        XCTAssertEqual(false, sut.isComplete)
    }
    
}
