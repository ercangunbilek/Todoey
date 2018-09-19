//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Ercan GÜNBİLEK on 14.09.2018.
//  Copyright © 2018 Ercan GÜNBİLEK. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    let realm = try! Realm()
    let dataFIlePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    var category : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFIlePath!)
        loadCategories()
    }
    
    //MARK - TableView DataSource method
    
    //table view'a satir bilgisi aktariliyor
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category?.count ?? 1
    }
    
    //table view'a satira sayiyisini verdikten sonra satirsayisi kadar hucre olusturup table view'a gonderiyoruz
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = category?[indexPath.row].name ?? "Not Added Category"
        return cell
    }
    
    //MARK - TableView Delagete Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    //Segue tetiklenmeden once bu calisir
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            
            destinationVC.selectedCategory = category?[indexPath.row]
            
        }
        
        
        
        
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in alertTextField.placeholder = "Add New Category"
            alertTextField.placeholder = "Add Category"
            textfield = alertTextField
        }
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newItem = Category()
            newItem.name = textfield.text!
            self.save(category: newItem)
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    func save(category : Category){
        
        
        do{
            
            try realm.write {
                realm.add(category)
            }
            
        }catch{
            print("Error : \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadCategories(){

        category = realm.objects(Category.self)
        tableView.reloadData()
    }

    
    
    
}
