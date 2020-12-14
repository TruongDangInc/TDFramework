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

public class TDServices: NSObject {
    public class func registerAccout(withUserName userName: String, password pass: String) -> [String] {
        UserDefaults.standard.setValue(userName, forKey: "register_user_name")
        UserDefaults.standard.setValue(pass, forKey: "register_password")
        UserDefaults.standard.synchronize()
        return [userName, pass]
    }

    public class func login(withUserName userName: String, password pass: String) -> [String] {
        UserDefaults.standard.setValue(userName, forKey: "user_name")
        UserDefaults.standard.setValue(pass, forKey: "password")
        UserDefaults.standard.synchronize()
        return [userName, pass]
    }
}
