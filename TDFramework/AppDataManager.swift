//
//                ______                                       __ _
//               /_  __/______  ______  ____  ____ _          / __ \____ _____  ____ _
//                / / / ___/ / / / __ \/ __ \/ __ `/         / / / / __ `/ __ \/ __ `/
//               / / / /  / /_/ / /_/ / / / / /_/ /         / /_/ / /_/ / / / / /_/ /
//              /_/ /_/   \__,_/\____/_/ /_/\__, /         /_____/\__,_/_/ /_/\__, /
//                                         /____/                            /____/
//
//  AppDataManager.swift
//  TDFramework
//
//  Created by Đặng Văn Trường on 16/12/2020.
//  Copyright (c) 2020 TruongDang Inc. All rights reserved.
//

import Foundation

class AppDataManager {
    private var appDataID: String
    private var appData: [String: Any] {
        defer {
            AppDataManager.locker.unlock()
        }
        AppDataManager.locker.lock()
        return AppDataManager.allAppDatas[self.appDataID] as? [String: Any] ?? [:]
    }
    
    private static let locker = NSRecursiveLock()
    
    private static var allAppDatas: [String: Any] = {
        defer {
            AppDataManager.locker.unlock()
        }
        AppDataManager.locker.lock()
        return AppDataManager.loadAllAppDatas()
    }()

    private static var persistentFileURL: URL {
        get {
            let url = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
            return url.appendingPathComponent("AppData.json")
        }
    }

    init() {
        self.appDataID = "AppData"
    }

    func trackedEvent() -> Any? {
        return self.appData["TrackedEvent"]
    }

    func set(trackedEvent: Any?) {
        var appData = self.appData
        appData["TrackedEvent"] = trackedEvent
        AppDataManager.locker.lock()
        AppDataManager.allAppDatas[appDataID] = appData
        AppDataManager.saveAllAppData()
        AppDataManager.locker.unlock()
    }

    private static func loadAllAppDatas() -> [String: Any] {
        guard let fileData = FileManager.default.contents(atPath: AppDataManager.persistentFileURL.path) else {
            return [:]
        }
        
        var appData: [String: Any] = [:]
        do {
            debugPrint("Loading all AppData...")
            appData = try JSONSerialization.jsonObject(with: fileData, options: .mutableContainers) as? [String: Any] ?? [:]
        } catch {
            debugPrint("Failed to read AppData file: \(error.localizedDescription)")
        }
        
        return appData
    }

    private static func saveAllAppData() {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: AppDataManager.allAppDatas, options: .prettyPrinted)
            try jsonData.write(to: AppDataManager.persistentFileURL, options: .atomic)
        } catch {
            debugPrint("Failed to save AppData: \(error.localizedDescription)")
        }
    }
}
