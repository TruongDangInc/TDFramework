//
//                ______                                       __ _
//               /_  __/______  ______  ____  ____ _          / __ \____ _____  ____ _
//                / / / ___/ / / / __ \/ __ \/ __ `/         / / / / __ `/ __ \/ __ `/
//               / / / /  / /_/ / /_/ / / / / /_/ /         / /_/ / /_/ / / / / /_/ /
//              /_/ /_/   \__,_/\____/_/ /_/\__, /         /_____/\__,_/_/ /_/\__, /
//                                         /____/                            /____/
//
//  CoreDataManager.swift
//  TDFramework
//
//  Created by Đặng Văn Trường on 17/12/2020.
//  Copyright (c) 2020 TruongDang Inc. All rights reserved.
//

import CoreData

let TDFrameworkBundle = Bundle(for: CoreDataManager.self)

enum CoreDataErrorCode : Int {
    // An internal error
    case internalError = 1
    // Could not load or create a persistent store
    case couldNotLoadOrCreatePersistentStore = 2
    // Could not save data to core data
    case couldNotSave = 3
    // Could not fetch data from core data
    case couldNotFetch = 4
}

class CoreDataManager {
    static let shared = CoreDataManager()
    
    static var error: NSError? = nil
    
    var TDFrameworkURL: URL = {
        var url: URL!
        do {
            let libURL = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0])
            url = libURL.appendingPathComponent("TDFramework")
            if !FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            }
        } catch {
            url = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        }
        return url
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        let path = TDFrameworkURL.appendingPathComponent("CoreData").path
        if !FileUtils.directoryExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                FileUtils.addSkipBackupAttributeToItem(filePath: path)
            } catch let error {
                print("Failed to create directory with error: \(error.localizedDescription)")
                return nil
            }
        }
        
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let name = "TDFramework.sqlite"
        let coreDataURL = URL(fileURLWithPath: path.stringByAppending(pathComponent: name))
        CoreDataManager.addPersistentStore(at: coreDataURL, coordinator: coordinator)
        return coordinator
    }()
    
    var backgroundManagedObjectContext: NSManagedObjectContext?
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = self.persistentStoreCoordinator
        context.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
        // We don't need undo operations. This will improve the performance.
        context.undoManager = nil
        return context
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = TDFrameworkBundle.url(forResource: "TDFramework", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    /*lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "TDFramework")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    @available(iOS 13.0, *)
    lazy var persistentCloudKitContainer: NSPersistentCloudKitContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentCloudKitContainer(name: "TDFramework")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()*/

    class func addPersistentStore(at url: URL, coordinator: NSPersistentStoreCoordinator) {
        let options = [NSMigratePersistentStoresAutomaticallyOption: true,
                       NSInferMappingModelAutomaticallyOption: true]
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            
            // Remove the corrupted store and create a new one.
            do {
                try FileManager.default.removeItem(at: url)
                try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
            }
            catch {
                // Try create the new one without options
                do {
                    try FileManager.default.removeItem(at: url)
                    try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
                }
                catch {
                    CoreDataManager.error = NSError(domain: "TDFramework.coreData", code: CoreDataErrorCode.couldNotLoadOrCreatePersistentStore.rawValue, userInfo: [NSLocalizedDescriptionKey : "Could not create or load Core Data."])
                }
            }
        }
    }

    // MARK: - Core Data Saving support
    func saveContext () {
        if let managedObjectContext = self.managedObjectContext, managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

class FileUtils: NSObject {
    class func addSkipBackupAttributeToItem(filePath:String) {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: filePath) {
            return
        }
        
        var url = URL(fileURLWithPath: filePath)
        url.setTemporaryResourceValue(true, forKey: .isExcludedFromBackupKey)
    }

    class func directoryExists(atPath dirPath: String) -> Bool {
        var isDir: ObjCBool = false
        let exists = FileManager.default.fileExists(atPath: dirPath, isDirectory: &isDir)
        return (exists && isDir.boolValue)
    }
}

extension String {
    func stringByAppending(pathComponent: String) -> String {
        return (self as NSString).appendingPathComponent(pathComponent)
    }
}
