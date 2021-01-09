//
//                ______                                       __ _
//               /_  __/______  ______  ____  ____ _          / __ \____ _____  ____ _
//                / / / ___/ / / / __ \/ __ \/ __ `/         / / / / __ `/ __ \/ __ `/
//               / / / /  / /_/ / /_/ / / / / /_/ /         / /_/ / /_/ / / / / /_/ /
//              /_/ /_/   \__,_/\____/_/ /_/\__, /         /_____/\__,_/_/ /_/\__, /
//                                         /____/                            /____/
//
//  Event.swift
//  TDFramework
//
//  Created by Đặng Văn Trường on 09/01/2021.
//  Copyright (c) 2021 TruongDang Inc. All rights reserved.
//

public enum EventType: String {
    case register = "Register"
    case login = "Login"
    case logout = "Logout"
}

public struct Event {
    public let type: EventType!
    public let message: String!
}
