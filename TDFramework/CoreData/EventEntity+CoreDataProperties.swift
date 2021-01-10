//
//                ______                                       __ _
//               /_  __/______  ______  ____  ____ _          / __ \____ _____  ____ _
//                / / / ___/ / / / __ \/ __ \/ __ `/         / / / / __ `/ __ \/ __ `/
//               / / / /  / /_/ / /_/ / / / / /_/ /         / /_/ / /_/ / / / / /_/ /
//              /_/ /_/   \__,_/\____/_/ /_/\__, /         /_____/\__,_/_/ /_/\__, /
//                                         /____/                            /____/
//
//  EventEntity+CoreDataProperties.swift
//  TDFramework
//
//  Created by Đặng Văn Trường on 18/12/2020.
//  Copyright (c) 2020 TruongDang Inc. All rights reserved.
//
//

import CoreData

extension EventEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventEntity> {
        return NSFetchRequest<EventEntity>(entityName: "EventEntity")
    }

    @NSManaged var message: String?
    @NSManaged var type: String?

    static func createEvent(with type: String, message: String) {
        let event = NSEntityDescription.insertNewObject(forEntityName: "EventEntity", into: CoreDataManager.shared.managedObjectContext ?? NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)) as! EventEntity
        event.type = type
        event.message = message
        CoreDataManager.shared.saveContext()
    }

    static func getAllEvents() -> [EventEntity] {
        var result = [EventEntity]()
        let moc = CoreDataManager.shared.managedObjectContext
        
        do {
            result = try moc!.fetch(EventEntity.fetchRequest()) as! [EventEntity]
        } catch let error {
            debugPrint("can not fetch events: \(error.localizedDescription)")
        }
        return result
    }
}
