//
//  ViewController.swift
//  Todoey
//
//  Created by Ercan GÜNBİLEK on 11.09.2018.
//  Copyright © 2018 Ercan GÜNBİLEK. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {

    let itemArray = ["Buy Milk" , "Buy Egg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}

