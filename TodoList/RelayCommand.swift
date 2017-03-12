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
    
    private let _execute: () -> Void
    private let _canExecute: () -> Bool
    private let _canExecuteChanged = PublishSubject<Unit>()
    
    init(execute: @escaping () -> Void) {
        _execute = execute
        _canExecute = { Void in true }
    }
    
    init(execute: @escaping () -> Void, canExecute: @escaping () -> Bool) {
        _execute = execute
        _canExecute = canExecute
    }
    
    var canExecuteChanged: Observable<Unit> { return _canExecuteChanged }
    
    func execute() {
        if canExecute() {
            _execute()
        }
    }
    
    func canExecute() -> Bool {
        return _canExecute()
    }
    
    func raiseCanExecuteChanged() {
        _canExecuteChanged.onNext(Unit())
    }
}
