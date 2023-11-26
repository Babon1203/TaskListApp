//
//  StorageManager.swift
//  TaskListApp
//
//  Created by Кирилл Саталкин on 26.11.2023.
//

import Foundation
import CoreData

final class StorageManager {
    static let shared = StorageManager()
    private let context: NSManagedObjectContext
    
    // MARK: - Core Data stack
    
    var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "TaskListApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init() {
    context = persistentContainer.viewContext
}
   
    func fetchData(completion: ([Task]) -> Void) {
        let fetchRequest = Task.fetchRequest()
        
        do {
            let tasks = try context.fetch(fetchRequest)
            completion(tasks)
        } catch {
            print(error)
        }
    }
    
        
    func saveTask(_ name: String, completion: (Task) -> Void) {
        let task = Task(context: context)
        task.title = name
        completion(task)
        saveContext()
    }

    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
}
