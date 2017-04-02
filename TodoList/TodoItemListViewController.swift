//
//  TodoItemListViewController.swift
//  TodoList
//
//  Created by Gyuwon Yi on 3/12/17.
//  Copyright © 2017 Gyuwon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TodoItemCell: UITableViewCell {

    @IBOutlet var descriptionLabel: UILabel!
    
    private var _binding: Disposable?
    
    var dataContext: TodoItemViewModel? = nil {
        didSet {
            _binding?.dispose()
            
            guard let dataContext = dataContext else {
                descriptionLabel.text = ""
                return
            }
            
            let fromViewModel = dataContext.propertyChanged.subscribe(onNext: { [weak self] propertyName in
                switch propertyName {
                case "description":
                    self?.descriptionLabel.text = self?.dataContext!.description
                    break
                default:
                    break
                }
            })
            
            _binding = CompositeDisposable(disposables: [fromViewModel])
            
            descriptionLabel.text = dataContext.description
        }
    }

}

class TodoItemListViewController: UITableViewController {
    
    private var _viewModel: TodoItemListViewModel {
        return ViewModelLocator.applicationModel.itemList
    }
    
    private var _binding: Disposable?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _binding?.dispose()
        
        _binding = _viewModel.items.collectionChanged.subscribe(onNext: { [weak self] _ in self?.tableView.reloadData() })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ServiceLocator.messageBox.currentViewController = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ServiceLocator.messageBox.currentViewController = nil
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _viewModel.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)

        if let cell = cell as? TodoItemCell {
            let itemViewModel = _viewModel.items[indexPath.row]
            cell.dataContext = itemViewModel
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        _viewModel.deleteItem.execute(parameter: indexPath.row)
    }

}
