//
//                ______                                       __ _
//               /_  __/______  ______  ____  ____ _          / __ \____ _____  ____ _
//                / / / ___/ / / / __ \/ __ \/ __ `/         / / / / __ `/ __ \/ __ `/
//               / / / /  / /_/ / /_/ / / / / /_/ /         / /_/ / /_/ / / / / /_/ /
//              /_/ /_/   \__,_/\____/_/ /_/\__, /         /_____/\__,_/_/ /_/\__, /
//                                         /____/                            /____/
//
//  TDFrameworkTests.swift
//  TDFrameworkTests
//
//  Created by Đặng Văn Trường on 14/12/2020.
//  Copyright (c) 2020 TruongDang Inc. All rights reserved.
//

import XCTest
@testable import TDFramework

class TDFrameworkTests: XCTestCase {
    func testRegisterAccout() throws {
        _ = TDServices.registerAccout(withUserName: "Login User Name", password: "SHA-1 Encrypted Password")
        let userName = UserDefaults.standard.string(forKey: "register_user_name")
        let pass = UserDefaults.standard.string(forKey: "register_password")
        
        XCTAssertEqual(userName, "Login User Name", "[😱] Oops! Username is wrong")
        XCTAssertEqual(pass, "SHA-1 Encrypted Password", "[😱] Oops! Password is wrong")
    }

    func testPerformanceRegisterAccout() throws {
        measure {
            _ = TDServices.registerAccout(withUserName: "Login User Name", password: "SHA-1 Encrypted Password")
        }
    }
}
