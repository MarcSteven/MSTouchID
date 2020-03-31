//
//  TouchIDState.swift
//  MSTouchID
//
//  Created by Marc Steven on 2020/3/31.
//  Copyright © 2020 Marc Steven. All rights reserved.
//

import Foundation


public  enum TouchIDState: Int {
    case notSupport = 1
    case success
    case failed
    case userCancel
    case  inputPassword
    case passwordNotSet
    case systemCancel
    case touchIDNotSet
    case touchIDNotAvailable
    case touchIDLockout
    case invalidContext
    case versionNotSupport
    case appCancel
    case notInteractive
    
}
