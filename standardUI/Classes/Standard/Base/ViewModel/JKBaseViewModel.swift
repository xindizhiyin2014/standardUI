//
//  JKBaseViewModel.swift
//  Pods
//
//  Created by JackLee on 2021/10/9.
//

import Foundation

/// track
public class JKTrackModel_Swift {
    public var eventName:String
    public var extra:Dictionary<String, Any>?
  public convenience init(eventName:String) {
       self.init(eventName:eventName,extra:nil)
    }
    
  public init(eventName:String, extra:Dictionary<String, Any>?) {
        self.eventName = eventName
        self.extra = extra
    }
}

public class JKBaseViewModel_Swift {
    public var jk_rawData:Any?
    public var jk_identifier:String?
    public var jk_size:CGSize?
    public var jk_trackModel:JKTrackModel_Swift?
}

public class JKBaseReuseViewModel_Swift:JKBaseViewModel_Swift,JKReuseViewModelProtocol_Swift {
    public var reuseViewClass: AnyClass
   public init(reuseViewClass:AnyClass) {
        self.reuseViewClass = reuseViewClass
    }
    
}
