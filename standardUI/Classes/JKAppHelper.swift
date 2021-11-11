//
//  JKAppHelper.swift
//  JKBasicProvider_Swift
//
//  Created by JackLee on 2021/9/26.
//

import Foundation
public class JKAppHelper {
   public func appVersion() -> String {
    let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
    return "\(appVersion ?? "")"
    }
    
    public func appBuildVersion() -> String {
        let appBuildVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion")
        return "\(appBuildVersion ?? "")"
    }
    
    public func appName() -> String {
        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName")
        return "\(appName ?? "")"
    }
    
    public func appDisplayName() ->String {
        let appDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName")
        return "\(appDisplayName ?? "")"
    }
}
