//
//  NewTodoItemFormViewController.swift
//  TodoList
//
//  Created by Gyuwon Yi on 3/12/17.
//  Copyright © 2017 Gyuwon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewTodoItemFormViewController: UIViewController {
    
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    private var _binding: Disposable? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _binding?.dispose()
        
        let viewModel: NewTodoItemFormViewModel = ViewModelLocator.applicationModel.newItemForm
        
        let fromViewModel = CompositeDisposable(disposables: [
            viewModel.propertyChanged.subscribe(onNext: { [weak self] propertyName in
                switch propertyName {
                case "description":
                    self?.descriptionField.text = viewModel.description
                    break;
                default:
                    break;
                }
            }),
            viewModel.submit.canExecuteChanged.subscribe(onNext: { [weak self] unit in
                let canExecuteCommand: Bool = viewModel.submit.canExecute()
                self?.submitButton.isEnabled = canExecuteCommand
            })
        ])
        
        let fromView = CompositeDisposable(disposables: [
            descriptionField.rx.text.subscribe(onNext: { value in viewModel.description = value! }),
            submitButton.rx.controlEvent(UIControlEvents.touchUpInside).subscribe(onNext: { [weak self] Void in
                viewModel.submit.execute()
                self?.dismiss(animated: true)
            })
        ])
        
        _binding = CompositeDisposable(disposables: [fromViewModel, fromView])
        
        descriptionField.text = viewModel.description
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onCancelButtonTouchUpInside(_ sender: Any) {
        self.dismiss(animated: true)
    }

}
