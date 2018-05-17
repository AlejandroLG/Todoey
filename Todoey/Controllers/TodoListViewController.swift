//
//  ViewController.swift
//  Todoey
//
//  Created by Alejandro López Gómez on 3/15/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    
    var itemArray = [Item]()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)

        let secondItem = Item()
        secondItem.title = "Buy Eggs"
        itemArray.append(secondItem)

        let thirdItem = Item()
        thirdItem.title = "Destroy Demogorgon"
        itemArray.append(thirdItem)

        if let items = defaults.value(forKey: "ToDoListArray") as? [Item] {
            self.itemArray = items
        }
    }

    //MARK: TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title

        cell.accessoryType = item.done ? .checkmark : .none

        return cell
    }

    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var alertTextfield = UITextField()
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Add Item", style: .default) { (action) in
            // Whta will happen once the user clicks the Add Item button
            let createdItem = Item()
            createdItem.title = alertTextfield.text!
            self.itemArray.append(createdItem)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        alert.addTextField { (textfield) in
            textfield.placeholder = "Create new item"
            alertTextfield = textfield
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
