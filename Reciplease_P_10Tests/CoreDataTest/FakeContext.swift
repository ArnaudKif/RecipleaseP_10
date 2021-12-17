//
//  FakeContext.swift
//  Reciplease_P_10Tests
//
//  Created by arnaud kiefer on 17/12/2021.
//

import Foundation
import CoreData
@testable import Reciplease_P_10


//class TestCoreDataManagement: FavoritesDataManagement {
//    override init() {
//        super.init()
//
//        // 1
//        let persistentStoreDescription = NSPersistentStoreDescription()
//        persistentStoreDescription.type = NSInMemoryStoreType
//
//        // 2
//        let container = NSPersistentContainer(
//            name: CoreDataStack.modelName,
//            managedObjectModel: CoreDataStack.model)
//
//        // 3
//        container.persistentStoreDescriptions = [persistentStoreDescription]
//
//        container.loadPersistentStores { _, error in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        }
//
//        // 4
//        storeContainer = container
//    }
//}

class TestContext {

    static let modelName = "Reciplease_P_10"

    static let model: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var testContainer : NSPersistentContainer = {
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType

        let container = NSPersistentContainer(name: TestContext.modelName, managedObjectModel: TestContext.model)

        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        return container
    }()

    static var testContainer: NSPersistentContainer {
        return TestContext().testContainer
    }

    static var testContext : NSManagedObjectContext {
        return testContainer.viewContext
    }

}


//
//class TestCoreDataStack: NSObject {
////    lazy var persistentContainer: NSPersistentContainer = {
////        let description = NSPersistentStoreDescription()
////        description.url = URL(fileURLWithPath: "/dev/null")
////        let container = NSPersistentContainer(name: "your_model_name")
////        container.persistentStoreDescriptions = [description]
////        container.loadPersistentStores { _, error in
////            if let error = error as NSError? {
////                fatalError("Unresolved error \(error), \(error.userInfo)")
////            }
////        }
////        return container
////    }()
//
//// MARK: - Core Data stack
//
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "RecipleaseTest")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
////    static var persistentContainer: NSPersistentContainer {
////        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
////    }
//
//    static var viewContext : NSManagedObjectContext {
//        return persistentContainer.viewContext
//    }
//
//    // MARK: - Core Data Saving support
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
//
//}
