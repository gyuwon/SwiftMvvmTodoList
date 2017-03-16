//
//  ObservableCollection_specs.swift
//  TodoList
//
//  Created by Gyuwon Yi on 3/12/17.
//  Copyright © 2017 Gyuwon. All rights reserved.
//

import XCTest
import RxSwift
@testable import TodoList

class ObservableCollection_specs: XCTestCase {

    func test_append_inserts_new_item_at_the_end_correctly() {
        // Arrange
        let sut = ObservableCollection<String>()
        let item = UUID().uuidString
        
        // Act
        sut.append(item: item)
        
        // Assert
        XCTAssertEqual(1, sut.count)
        let actual: String = sut[0]
        XCTAssertEqual(item, actual)
    }
    
    func test_append_raises_collectionChanged_event_correctly() {
        // Arrange
        let sut = ObservableCollection<String>()
        sut.append(item: UUID().uuidString)
        let item = UUID().uuidString
        var events = [CollectionChanged<String>]()
        _ = sut.collectionChanged.subscribe(onNext: { event in events.append(event) })
        
        // Act
        sut.append(item: item)
        
        // Assert
        XCTAssertEqual(1, events.count)
        switch events[0] {
        case .itemsAdded(let location, let items):
            XCTAssertEqual(1, location)
            XCTAssertEqual(1, items.count)
            XCTAssertEqual(item, items[0])
            break
        default:
            XCTFail("collectionChanged event is not raised correctly.")
        }
    }
    
    func test_remove_at_removes_item_at_the_specified_index() {
        // Arrange
        var data = [UUID().uuidString, UUID().uuidString, UUID().uuidString]
        let sut = ObservableCollection<String>()
        for i in 0..<3 {
            sut.append(item: data[i])
        }
        let index = Int(arc4random_uniform(UInt32(sut.count)))
        
        // Act
        sut.remove(at: index)
        
        // Assert
        data.remove(at: index)
        XCTAssertEqual(data.count, sut.count)
        for i in 0..<data.count {
            XCTAssertEqual(data[i], sut[i])
        }
    }
    
    func test_remove_at_raises_collectionChanged_event_correctly() {
        // Arrange
        var data = [UUID().uuidString, UUID().uuidString, UUID().uuidString]
        let sut = ObservableCollection<String>()
        for i in 0..<3 {
            sut.append(item: data[i])
        }
        var events = [CollectionChanged<String>]()
        _ = sut.collectionChanged.subscribe(onNext: { event in events.append(event) })
        let index = Int(arc4random_uniform(UInt32(sut.count)))
        
        // Act
        sut.remove(at: index)
        
        // Assert
        XCTAssertEqual(1, events.count)
        switch events[0] {
        case .itemsRemoved(let location, let items):
            XCTAssertEqual(index, location)
            XCTAssertEqual(1, items.count)
            XCTAssertEqual(data[index], items[0])
            break
        default:
            XCTFail("collectionChanged event is not raised correctly.")
        }
    }
    
}
