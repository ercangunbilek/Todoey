//
//  ViewController.swift
//  Todoey
//
//  Created by Ercan GÜNBİLEK on 11.09.2018.
//  Copyright © 2018 Ercan GÜNBİLEK. All rights reserved.
//

import UIKit
import RealmSwift
class TodoViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var todoItems : Results<Item>?

    var selectedCategory : Category? {
        didSet{
            //Kategori bir deger ile yuklendiginde calisir
            loadItem()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    //MARK - TableView DataSource method
    
    //table view'a satir bilgisi aktariliyor
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    
    //table view'a satira sayiyisini verdikten sonra satirsayisi kadar hucre olusturup table view'a gonderiyoruz
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done == true ? .checkmark : .none
        }else{
            cell.textLabel?.text = "No items added"
        }
        
        return cell
    }
    
    
    
    //MARK - TableView Delagete Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row]{
            
            do{
                try realm.write {
                    item.done = !item.done
                }
            }catch{
                print("Error saving status \(error)")
            }
            
            tableView.reloadData()
            
        }
        
        
    }
    
    
    //MARK - Add New Item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in alertTextField.placeholder = "Add New Item"
            alertTextField.placeholder = "Add item"
            textfield = alertTextField
        }
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write {
                    let newItem = Item()
                    newItem.title = textfield.text!
                    currentCategory.items.append(newItem)
                }
                }catch{
                    print("Error category \(error)")
                }
                
                self.tableView.reloadData()
                
            }
            
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    func loadItem(){
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        
        tableView.reloadData()
    }
}

//MARK: Search bar methods
extension TodoViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "date", ascending: true)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
            loadItem()
        }
    }
    
}

















