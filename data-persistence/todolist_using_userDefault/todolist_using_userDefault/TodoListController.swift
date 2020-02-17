//
//  ViewController.swift
//  todolist_using_userDefault
//
//  Created by shin seunghyun on 2020/02/17.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

class TodoListController: UITableViewController {
    
    var todoItems: [String] = []
    let userDefaults: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let safeItems: [String] = userDefaults.array(forKey: "TodoItems") as? [String] {
            todoItems = safeItems
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell")
        cell?.textLabel!.text = todoItems[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        let isChecked = cell?.accessoryType == .checkmark
        cell?.accessoryType = isChecked ? .none : .checkmark
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField: UITextField = UITextField()
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let newItem: String = textField.text {
                self.todoItems.append(newItem)
                self.userDefaults.set(self.todoItems, forKey: "TodoItems")
                self.tableView.reloadData()
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

