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
    case failed
    case success
    case userCancel
    case inputPassword
    case systemCancel
    case passwordNotSet
    case touchIDNotSet
    case touchIDNotAvailable
    case touchIDLockout
    case appCancel
    case invalidContext
    case versionNotSupport
    
}
