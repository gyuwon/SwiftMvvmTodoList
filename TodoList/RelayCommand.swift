//
//  Command.swift
//  TodoList
//
//  Created by Gyuwon Yi on 3/12/17.
//  Copyright © 2017 Gyuwon. All rights reserved.
//

import Foundation
import RxSwift

class RelayCommand {
    
    private let _execute: (Any?) -> Void
    private let _canExecute: (Any?) -> Bool
    private let _canExecuteChanged = PublishSubject<Unit>()
    
    init(execute: @escaping (Any?) -> Void) {
        _execute = execute
        _canExecute = { Void in true }
    }
    
    init(execute: @escaping (Any?) -> Void, canExecute: @escaping (Any?) -> Bool) {
        _execute = execute
        _canExecute = canExecute
    }
    
    var canExecuteChanged: Observable<Unit> { return _canExecuteChanged }
    
    func execute(parameter: Any? = nil) {
        if canExecute(parameter: parameter) {
            _execute(parameter)
        }
    }
    
    func canExecute(parameter: Any? = nil) -> Bool {
        return _canExecute(parameter)
    }
    
    func raiseCanExecuteChanged() {
        _canExecuteChanged.onNext(Unit())
    }
}
