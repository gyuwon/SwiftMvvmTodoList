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
        sut.append(item: item);
        
        // Assert
        XCTAssertEqual(1, sut.count)
        let actual: String = sut[0]
        XCTAssertEqual(item, actual)
    }
    
    func test_append_raises_collectionChanged_event_correctly(){
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
    
}
