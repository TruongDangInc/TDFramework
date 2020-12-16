//
//                ______                                       __ _
//               /_  __/______  ______  ____  ____ _          / __ \____ _____  ____ _
//                / / / ___/ / / / __ \/ __ \/ __ `/         / / / / __ `/ __ \/ __ `/
//               / / / /  / /_/ / /_/ / / / / /_/ /         / /_/ / /_/ / / / / /_/ /
//              /_/ /_/   \__,_/\____/_/ /_/\__, /         /_____/\__,_/_/ /_/\__, /
//                                         /____/                            /____/
//
//  TDServices.swift
//  TDFramework
//
//  Created by Đặng Văn Trường on 14/12/2020.
//  Copyright (c) 2020 TruongDang Inc. All rights reserved.
//

import UIKit

public class TDServices {
    public static var shared = TDServices()

    @discardableResult public func registerAccout(withName username: String, password pass: String) -> [String:String] {
        let event = ["Register":"[\(Date().debugDescription)] Registed account with username \"\(username)\", password[SHA-1 encrypted] \"\(pass)\""]
        let manager = AppDataManager()
        var trackedEvent = manager.trackedEvent() as? [[String:String]]
        if trackedEvent == nil {
            trackedEvent = [event]
        } else {
            trackedEvent!.append(event)
        }
        manager.set(trackedEvent: trackedEvent)
        return [username:pass]
    }

    @discardableResult public func login(withName username: String, password pass: String) -> [String:String] {
        let event = ["Login":"[\(Date().debugDescription)] Loged in with username \"\(username)\", password[SHA-1 encrypted] \"\(pass)\""]
        let manager = AppDataManager()
        var trackedEvent = manager.trackedEvent() as? [[String:String]]
        if trackedEvent == nil {
            trackedEvent = [event]
        } else {
            trackedEvent!.append(event)
        }
        manager.set(trackedEvent: trackedEvent)
        return [username:pass]
    }

    @discardableResult public func logout() -> [String:String] {
        let event = ["Logout":"[\(Date().debugDescription)] Loged out!"]
        let manager = AppDataManager()
        var trackedEvent = manager.trackedEvent() as? [[String:String]]
        if trackedEvent == nil {
            trackedEvent = [event]
        } else {
            trackedEvent!.append(event)
        }
        manager.set(trackedEvent: trackedEvent)
        return [:]
    }

    @discardableResult public func history() -> [[String:String]]? {
        let manager = AppDataManager()
        return manager.trackedEvent() as? [[String:String]]
    }
}
