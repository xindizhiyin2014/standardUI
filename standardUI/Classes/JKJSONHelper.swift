//
//  JKJSONHelper.swift
//  JKBasicProvider_Swift
//
//  Created by JackLee on 2021/9/26.
//

import Foundation
public class JKJSONHelper {
   /// arrary convert to string
   func jsonString(withArray array:Array<String>) -> String?  {
        var jsonString:String? = nil
        do {
            let data:Data? = try JSONSerialization.data(withJSONObject: array, options: JSONSerialization.WritingOptions.prettyPrinted)
            if let jsonData = data {
                jsonString = String.init(data: jsonData, encoding: .utf8)
            }
        } catch {
            #if DEBUG
            assert(false, error.localizedDescription)
            #endif
        }
        return jsonString;
    }
    
    /// dictionary convert to string
    func jsonString(withDic dic:Dictionary<String,Any>) -> String? {
        var jsonString:String? = nil
        do {
            let data:Data? = try JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted)
            if let jsonData = data {
                jsonString = String.init(data: jsonData, encoding: .utf8)
            }
        } catch {
            #if DEBUG
            assert(false, error.localizedDescription)
            #endif
        }
        return jsonString
    }
    
    /// dictionary convert to queryString
     func queryString(withDic dic:Dictionary<String,String>) -> String? {
        var string:String?
        for (key, value) in dic.enumerated(){
            
            if string == nil {
                string = String.init()
            }
            if string!.count > 0 {
                string!.append("&")
            }
            let keyValueString = "\(key)=\(value)"
            string!.append(keyValueString)
        }
        return string
    }
    /// Data convert to Dictionary
    func dic(withData data:Data) -> Dictionary<String,Any>? {
        var dic:Dictionary<String, Any>? = nil
        do {
            dic = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, Any>
        } catch  {
            #if DEBUG
            assert(false, error.localizedDescription)
            #endif
        }
        return dic
    }
    
    /// jsonObject convert to data
    func data(withJsonObject jsonObject:Any) -> Data? {
        var data:Data? = nil
        do {
            data = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch {
            #if DEBUG
            assert(false, error.localizedDescription)
            #endif
        }
        return data
   }
    
    /// url字符串中的query转换为Dictionary
    /// - Parameter url: url
    /// - Returns: Dictionary对象
    func dic(url:String) -> Dictionary<String,String>? {
        if url.count == 0 {
            return nil
        }
        var params = [String:String]()
        let components = URLComponents.init(string: url)
        guard components != nil else {
            return nil
        }
        guard components!.queryItems != nil else {
            return nil
        }
        for item in components!.queryItems! {
            params[item.name] = item.value
        }
        return params
    }
}
