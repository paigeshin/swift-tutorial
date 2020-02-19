//
//  ViewController.swift
//  Todoey
//
//  Created by Angela Yu on 16/11/2017.
//  Copyright © 2017 Angela Yu. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class TodoListViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    var todoItemArray: Results<TodoItem>?
    
    var selecetedTodoParent : TodoParent? {
        didSet{
            loadItems()
        }
    }
    
    var selectedColor: String?
    
    override func viewWillAppear(_ animated: Bool) {
        if let colorHex = selectedColor {
            title = selecetedTodoParent!.name
            guard let navBar = navigationController?.navigationBar else { fatalError("Navigation Controller does not exist.") }
            if let navBarColor = UIColor(hexString: colorHex){
                navBar.backgroundColor = navBarColor
                navBar.barTintColor = navBarColor
                navBar.tintColor = ContrastColorOf(navBarColor, returnFlat: true)
                navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ContrastColorOf(navBarColor, returnFlat: true)]
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItemArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let todoItem = todoItemArray?[indexPath.row] {
            cell.textLabel?.text = todoItem.title
            if let color = UIColor(hexString: self.selectedColor!)!.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(todoItemArray!.count)) {
                cell.backgroundColor = color
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
            }
            cell.accessoryType = todoItem.done ? .checkmark : .none
        } 
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let todoItem = todoItemArray?[indexPath.row] {
            do {
                try realm.write {
                    todoItem.done = !todoItem.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Update Table
    
    override func updateModel(at indexPath: IndexPath) {
        super.updateModel(at: indexPath)
        if let todoItemDeletion = self.todoItemArray?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(todoItemDeletion)
                }
            } catch {
                print("Error deleting Item: \(error)")
            }
        }
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let currentParentTodo = self.selecetedTodoParent {
                do {
                    try self.realm.write {
                        let newTodoItem = TodoItem()
                        newTodoItem.title = textField.text!
                        currentParentTodo.items.append(newTodoItem)
                        newTodoItem.dateCreated = Date()
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        loadItems()
    }
    
    
    func loadItems() {
        
        //NSPredicate, CoreData를 사용할 때, Sorting을 해주듯이, Realm에서도 data sorting이 가능하다.
        todoItemArray = selecetedTodoParent?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
        
    }
    
}

//MARK: - Search bar methods

extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //NSPredicate
        todoItemArray =
            todoItemArray?
                .filter("title CONTAINS[cd] %@", searchBar.text!)
                .sorted(byKeyPath: "dateCreated", ascending: true)
        
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
        
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}




