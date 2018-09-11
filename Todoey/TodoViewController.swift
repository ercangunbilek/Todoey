//
//  ViewController.swift
//  Todoey
//
//  Created by Ercan GÜNBİLEK on 11.09.2018.
//  Copyright © 2018 Ercan GÜNBİLEK. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {

    
    let defaults = UserDefaults.standard // Uygulamayi kapattigimizda veri kaybi yasanmamasi icin
    var itemArray = ["Buy Milk" , "Buy Egg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad")
        if let userArray = defaults.array(forKey: "listArray") as? [String]{
            //Uygulamayi kapattigimizda verileri .plist'ten cekiyoruz.Boylece verileri ekranda tekrar listeliyoruz
            itemArray = userArray
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    //MARK - TableView DataSource method
    
    //table view'a satir bilgisi aktariliyor
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    //table view'a satira sayiyisini verdikten sonra satirsayisi kadar hucre olusturup table view'a gonderiyoruz
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    //MARK - TableView Delagete Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        //deselectRow methodu secim islemi yapildiktan belirli sure sonra arka plani eski haline getiriyor
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Secili hucreye onay tiki koyuyoruz
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark  {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
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
            print(textfield.text!)
            self.itemArray.append(textfield.text!)
            self.defaults.set(self.itemArray, forKey: "listArray") //Uygulamayi kapattigimizda veri kaybi yasanmamasi icin
            self.tableView.reloadData()
            //print(self.itemArray[self.itemArray.count-1])
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
}









