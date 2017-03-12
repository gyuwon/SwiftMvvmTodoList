//
//  ObservableCollection.swift
//  TodoList
//
//  Created by Gyuwon Yi on 3/12/17.
//  Copyright © 2017 Gyuwon. All rights reserved.
//

import Foundation
import RxSwift

enum CollectionChanged<T> {

    case itemsAdded(Int, [T])
    case itemsRemoved(Int, [T])
    case reset
    
}

class ObservableCollection<T>: Collection {
    
    private var _collection = [T]()
    private var _collectionChanged = PublishSubject<CollectionChanged<T>>()
    
    var startIndex: Int { return _collection.startIndex }
    var endIndex: Int { return _collection.endIndex }
    subscript(position: Int) -> T { return _collection[position] }
    var collectionChanged: Observable<CollectionChanged<T>> { return _collectionChanged }
    
    func index(after i: Int) -> Int {
        guard i < endIndex else { fatalError("The parameter after must be less than endIndex.") }
        return i + 1
    }
    
    func append(item: T) {
        let location = _collection.count
        _collection.append(item)
        _collectionChanged.onNext(CollectionChanged<T>.itemsAdded(location, [item]))
    }

}
