//
//  FakeContext.swift
//  Reciplease_P_10Tests
//
//  Created by arnaud kiefer on 17/12/2021.
//

import Foundation
import CoreData
@testable import Reciplease_P_10

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
