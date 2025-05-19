//
//  ActionManager.swift
//  test2
//
//  Created by User1 on 13/05/2025.
//

import Foundation
import CoreData
import UIKit

class ActionManager {
    private init(){}
    static var shared = ActionManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription,error) in
            if let error = error as NSError?{
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //Quản lý đối tượng context
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    //Lấy tất cả đối tượng
    func fetchAllTask() -> [Task]{
        do {
            return try ActionManager.shared.viewContext.fetch(Task.fetchRequest())
        }
        catch {
            debugPrint(error)
            return []
        }
    }
    
    //Lưu context
    func saveContext(){
        guard viewContext.hasChanges else {return}
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            // Xử lý lỗi khi lưu context
        }
    }
    
    func deleteContext(_ object:NSManagedObject){
        viewContext.delete(object)
        do {
            try viewContext.save()
        }
        catch (let error){
            debugPrint(error)
        }
    }
}
