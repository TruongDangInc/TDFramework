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

import Foundation

public class TDServices {
    public static var shared = TDServices()

    @discardableResult public func registerAccout(withName username: String, password pass: String) -> [String:String] {
        EventEntity.createEvent(with: EventType.register.rawValue, message: "[\(Date().debugDescription)] Registed account with username \"\(username)\", password[SHA-1 encrypted] \"\(pass)\"")
        return [username:pass]
    }

    @discardableResult public func login(withName username: String, password pass: String) -> [String:String] {
        EventEntity.createEvent(with: EventType.login.rawValue, message: "[\(Date().debugDescription)] Loged in with username \"\(username)\", password[SHA-1 encrypted] \"\(pass)\"")
        return [username:pass]
    }

    @discardableResult public func logout() -> [String:String] {
        EventEntity.createEvent(with: EventType.logout.rawValue, message: "[\(Date().debugDescription)] Loged out!")
        return [:]
    }

    @discardableResult public func history() -> [Event] {
        let events = EventEntity.getAllEvents()
        return events.map { (event) -> Event in
            return Event(type: EventType(rawValue: event.type ?? ""), message: event.message)
        }
    }
}
