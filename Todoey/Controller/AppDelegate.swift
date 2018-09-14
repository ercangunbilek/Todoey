//
//  AppDelegate.swift
//  Todoey
//
//  Created by Ercan GÜNBİLEK on 11.09.2018.
//  Copyright © 2018 Ercan GÜNBİLEK. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        //çekirdek veri veri modelimizi kullanarak yeni ve kalıcı bir kapsayıcı oluşturmamız ve bu kalıcı konteyner de tasarruf edecek olduğumuz veritabanı.
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext //bu sayede değişikliği değiştirebiliyorsunuz, formunuzdan memnun kalana kadar verilerinizi silin.
        if context.hasChanges {
            do {
                //kalıcı depolama sözü verdik.
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
}

