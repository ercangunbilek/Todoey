//
//  ViewController.swift
//  Todoey
//
//  Created by Ercan GÜNBİLEK on 11.09.2018.
//  Copyright © 2018 Ercan GÜNBİLEK. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {
    
    // -- File Manager
    let dataFIlePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    var itemArray = [Item]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItem()
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
        print(itemArray[indexPath.row].title)
        //deselectRow methodu secim islemi yapildiktan belirli sure sonra arka plani eski haline getiriyor
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Secili hucreye onay tiki koyuyoruz
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark  {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            itemArray[indexPath.row].done = false
            self.saveItem()
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            itemArray[indexPath.row].done = true
            self.saveItem()
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
            
            let newItem = Item(title: textfield.text!, done: false)
            self.itemArray.append(newItem)
            
            self.saveItem()
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    func saveItem(){
        let encoder = PropertyListEncoder()
        
        do{
            
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFIlePath!)
            
        }catch{
            print("Encoding Item Error \(error)")
        }
        
        
        tableView.reloadData()
        
    }
    
    func loadItem(){
        if let data = try? Data(contentsOf: dataFIlePath!){
            
            let decoder = PropertyListDecoder()
            
            do{
                
                itemArray = try decoder.decode([Item].self, from: data)
                
            }catch{
                print("Error decode time")
            }
            
            
        }
    }
    
    
}









