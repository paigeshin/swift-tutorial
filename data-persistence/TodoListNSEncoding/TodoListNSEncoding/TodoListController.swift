//
//  ViewController.swift
//  TodoListNSEncoding
//
//  Created by shin seunghyun on 2020/02/17.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

class TodoListController: UITableViewController {
    
    var itemArray: [Item] = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        let item: Item = itemArray[indexPath.row]
        cell.accessoryType = item.isDone ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.itemArray[indexPath.row].isDone = !self.itemArray[indexPath.row].isDone
            self.saveItems()
            let cell = tableView.cellForRow(at: indexPath)
            let isDone = cell?.accessoryType == .checkmark
            cell?.accessoryType = isDone ? .none : .checkmark
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        var textField: UITextField = UITextField()
        let alert = UIAlertController(title: "Add new Todo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let newItemText = textField.text {
                var newItem: Item = Item()
                newItem.title = newItemText
                newItem.isDone = false
                self.itemArray.append(newItem)
                self.tableView.reloadData()
                DispatchQueue.main.async {
                    self.saveItems()
                }
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!) {
            do {
                let decoder = PropertyListDecoder()
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding itemArray, \(error)")
            }
        }
        tableView.reloadData()
    }
    
}

