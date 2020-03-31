//
//  MSTouchID.swift
//  MSTouchID
//
//  Created by Marc Steven on 2020/3/31.
//  Copyright © 2020 Marc Steven. All rights reserved.
//

import LocalAuthentication


typealias StateCompletionHandler = (TouchIDState,Error?) ->Void
open class MSTouchID:LAContext {
    static var instance:MSTouchID? = {
        var instance = MSTouchID()
        return instance
    }()
    class func shared() ->Self {
        return instance! as! Self
    }
    func ms_show(withDescribe desc:String?
        ,completion completionHandler:@escaping StateCompletionHandler) {
        self.ms_showTouchID(withDescribe: desc, faceIDDescribe: nil, completionHandler: completionHandler)
    }
    func ms_showTouchID(withDescribe desc:String?,
                        faceIDDescribe faceDesc:String?,
                        completionHandler:@escaping StateCompletionHandler) {
        let supportType = ms_canSupportBiometrics()
        var descString:String?
        if supportType == .touchID && (desc?.count ?? 0) == 0 {
            descString = "通过Home键验证已有指纹"
        }else {
            descString = desc
        }
        if supportType == .faceID && (faceDesc?.count ?? 0) == 0 {
            descString = "通过面容ID验证"
        }else {
            descString = faceDesc
        }
        if NSFoundationVersionNumber < NSFoundationVersionNumber10_8_1 {
            DispatchQueue.main.async {
                completionHandler(.versionNotSupport,nil)
            }
            return
        }
        let context = LAContext()
        context.localizedFallbackTitle = " 输入密码验证"
        var error:NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error ) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: descString ?? "", reply: {
                success,error in
                if success {
                    DispatchQueue.main.async(execute: {
                        completionHandler(.success,error)
                    })
                }else if error != nil {
                    switch (error as NSError?)?.code {
                    case LAError.Code.authenticationFailed.rawValue:
                        DispatchQueue.main.async(execute: {
                            completionHandler(.failed,error)
                        })
                    case LAError.Code.userCancel.rawValue:
                        DispatchQueue.main.async(execute: {
                            #if DEBUG
                           
                            #endif
                            completionHandler(.userCancel,error)
                        })
                    case LAError.Code.biometryLockout.rawValue:
                        DispatchQueue.main.async(execute: {
                            completionHandler(.touchIDLockout,error)
                        })
                    case LAError.Code.invalidContext.rawValue:
                        DispatchQueue.main.async(execute: {
                            completionHandler(.invalidContext,error)

                        })
                    case LAError.Code.biometryNotAvailable.rawValue:
                        DispatchQueue.main.async(execute: {
                            completionHandler(.touchIDNotAvailable,error)
                        })
                    case LAError.Code.passcodeNotSet.rawValue:
                        DispatchQueue.main.async(execute: {
                            completionHandler(.passwordNotSet,error)
                        })
                    case LAError.Code.appCancel.rawValue:
                        DispatchQueue.main.async(execute: {
                            completionHandler(.appCancel,error)
                        })
                    case LAError.Code.notInteractive.rawValue:
                        DispatchQueue.main.async(execute: {
                        })
                    
                    default:
                        break
                    }
                }
                        
            })
        }else {
            DispatchQueue.main.async(execute: {
                completionHandler(.notSupport,error)
            })
        }
    }
        
    }
    func ms_canSupportBiometrics() ->TouchIDSupportType {
        let context = LAContext()
        var error:NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            if error != nil {
                return .none
            }
            if #available(iOS 11.0, *) {
                return context.biometryType == .faceID ? TouchIDSupportType.faceID : TouchIDSupportType.touchID
            }
        }
        return .none
    }

