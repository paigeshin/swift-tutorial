//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Angela Yu on 01/12/2017.
//  Copyright © 2017 Angela Yu. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    //Result Keyword를 쓰면 auto update 할 수 있다. 즉 object를 추가했을 때, array.append() 메소를 호출하지 않아도 된다.
    //Optional 왜냐면 값이 없을 수도 있기 때문이다.
    var todoParents: Results<TodoParent>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation Controller does not exist.") }
        navBar.backgroundColor = UIColor(hexString: "1D9BF6")
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoParents?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath) //SwipeTableViewController에서 알아서 SwipeTableViewCell로 각각의 cell들을 casting 해준다.
        if let todoParent = todoParents?[indexPath.row]{
            cell.textLabel?.text = todoParent.name
            let color: String = todoParent.color 
            cell.backgroundColor = UIColor(hexString: color)
            cell.textLabel?.textColor = ContrastColorOf(UIColor(hexString: color)!, returnFlat: true)
        }

        return cell
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selecetedTodoParent = todoParents?[indexPath.row]
            destinationVC.selectedColor = todoParents?[indexPath.row].color
        }
    }
    
    //MARK: - Data Manipulation Methods
    
    func save(todoParent: TodoParent) {
        do {
            try realm.write {
                realm.add(todoParent)
                tableView.reloadData()
            }
        } catch {
            print("Error saving category \(error)")
        }
    }
    
    func loadCategories() {
        todoParents = realm.objects(TodoParent.self)
        tableView.reloadData()
    }
    
    //MARK: - Delete Data Frolm Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        super.updateModel(at: indexPath)
        if let categoryForDeletion = self.todoParents?[indexPath.row]{
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting Item: \(error)")
            }
        }
    }
    
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newTodoParent = TodoParent()
            newTodoParent.name = textField.text!
            newTodoParent.color = UIColor.randomFlat().hexValue()
            print("UIColor Hexadecimal \(newTodoParent.color)")
            self.save(todoParent: newTodoParent)
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

