//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Alejandro López Gómez on 5/21/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categories: [Category] = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }

    //MARK: - Tableview data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = category.name
        return cell
    }

    //MARK: - Tableview delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }

    //MARK: - Data manipulation methods
    func loadCategories() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categories = try context.fetch(request)
        } catch {
            print("Couldn't fetch categories data")
        }
        self.tableView.reloadData()
    }

    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Couldn't save the context \(error)")
        }
        self.tableView.reloadData()
    }

    //MARK: - Add new categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var alertTextfield = UITextField()
        let alert = UIAlertController(title: "", message: "Add new Category", preferredStyle: .alert)
        let add = UIAlertAction(title: "Add", style: .default) { (action) in
            if !(alertTextfield.text!.isEmpty) {
                let category = Category(context: self.context)
                category.name = alertTextfield.text
                self.categories.append(category)
                self.saveCategories()
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addTextField { (textfield) in
            textfield.placeholder = "Create new category"
            alertTextfield = textfield
        }
        alert.addAction(add)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }

    //MARK: - Navigation method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! TodoListViewController
        if let indexPath = self.tableView.indexPathForSelectedRow {
            destination.selectedCategory = categories[indexPath.row]
        }
    }
}
