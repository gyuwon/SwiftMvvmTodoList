//
//  RelayCommand_specs.swift
//  TodoList
//
//  Created by Gyuwon Yi on 3/12/17.
//  Copyright © 2017 Gyuwon. All rights reserved.
//

import XCTest
import RxSwift
@testable import TodoList

class RelayCommand_specs: XCTestCase {
    
    func test_execute_relays_to_function() {
        // Arrange
        var monitor: Int = 0
        let sut = RelayCommand(execute: { Void in monitor = monitor + 1 })
        
        // Act
        sut.execute()
        
        // Assert
        XCTAssertEqual(1, monitor)
    }
    
    func test_canExecute_relays_to_function() {
        // Arrange
        let expected = false
        let sut = RelayCommand(execute: { Void in }, canExecute: { Void in expected })
        
        // Act
        let actual: Bool = sut.canExecute()
        
        // Assert
        XCTAssertEqual(expected, actual)
    }
    
    func test_execute_does_not_relay_if_cannot_execute() {
        // Arrange
        var monitor: Int = 0
        let sut = RelayCommand(execute: { Void in monitor = monitor + 1 }, canExecute: { Void in false })
        
        // Act
        sut.execute()
        
        // Assert
        XCTAssertEqual(0, monitor)
    }
    
    func test_raiseCanExecuteChanged_raises_canExecuteChanged_event() {
        // Arrange
        let sut = RelayCommand(execute: { Void in })
        var events = [Void]()
        _ = sut.canExecuteChanged.subscribe(onNext: { event in events.append(event) })
        
        // Act
        sut.raiseCanExecuteChanged()
        
        // Assert
        XCTAssertEqual(1, events.count)
    }
    
}
