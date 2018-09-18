//
//  ViewController.swift
//  Todoey
//
//  Created by Ercan GÜNBİLEK on 11.09.2018.
//  Copyright © 2018 Ercan GÜNBİLEK. All rights reserved.
//

import UIKit
import CoreData
class TodoViewController: UITableViewController {
    
    // -- File Manager
    let dataFIlePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate) .persistentContainer.viewContext
    var selectedCategory : Category? {
        didSet{
            //Kategori bir deger ile yuklendiginde calisir
            loadItem()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFIlePath!)
        
        print(dataFIlePath!)
    }
    
    
    //MARK - TableView DataSource method
    
    //table view'a satir bilgisi aktariliyor
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    //table view'a satira sayiyisini verdikten sonra satirsayisi kadar hucre olusturup table view'a gonderiyoruz
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        cell.accessoryType = itemArray[indexPath.row].done == true ? .checkmark : .none
        return cell
    }
    
    
    
    //MARK - TableView Delagete Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row].title!)
        //deselectRow methodu secim islemi yapildiktan belirli sure sonra arka plani eski haline getiriyor
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Secili hucreye onay tiki koyuyoruz
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        self.saveItem()
        
        
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
            
            
            
            let newItem = Item(context: self.context)
            newItem.title = textfield.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            
            self.saveItem()
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    func saveItem(){
        
        
        do{
            
            try context.save()
            
        }catch{
            print("Error : \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadItem(with request : NSFetchRequest<Item> = Item.fetchRequest() , predicate : NSPredicate? = nil){
        
        
        let categoryPredicate  = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPrediciate = predicate {
            
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionalPrediciate])
            
        }else{
            request.predicate = categoryPredicate
        }
        
        do{
            itemArray = try context.fetch(request)
            
        }catch{
            print("Data load problem")
        }
        
        tableView.reloadData()
    }
}

//MARK: Search bar methods
extension TodoViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@",searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItem(with: request , predicate: predicate)
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

















