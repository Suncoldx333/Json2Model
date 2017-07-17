//
//  Json2Model.swift
//  Json2Model
//
//  Created by 11111 on 2017/7/17.
//  Copyright © 2017年 None. All rights reserved.
//

import UIKit

public enum Type: Int {
    
    case number
    case string
    case bool
    case array
    case dictionary
    case null
    case unknown
}

struct JSON {
    
    /// Create a JSON with given response
    ///
    /// - Parameters:
    ///   - responesObject: The response from networking framework
    ///   - opt: The serialization reading options
    /// - Throws: Failed in converting
    init<T>(_ responseObject : T,oprions opt : JSONSerialization.ReadingOptions = []){
        switch responseObject {
            
        case let dataObject as Data:
            do {
                let object : Any = try JSONSerialization.jsonObject(with: dataObject, options: opt)
                self.init(jsonObject: object)
            } catch  {
                self.init(jsonObject: NSNull())
            }
            
        case let stringObject as String:
            if let data = stringObject.data(using: .utf8) {
                do {
                    let object : Any = try JSONSerialization.jsonObject(with: data, options: opt)
                    self.init(jsonObject: object)
                } catch  {
                    self.init(jsonObject: NSNull())
                }
            }else{
                self.init(jsonObject: NSNull())
            }
            
        default:
            self.init(jsonObject: NSNull())
        }
    }

    fileprivate init(jsonObject : Any) {
        self.innerObject = jsonObject
    }
    
    var innerObject : Any{
        get{
            return "1"
        }
        set{
            switch unwrap(newValue) {
            case let number as NSNumber:
                print("\(number)")
            default:
                print("none")
            }
        }
    }
    
    
    static var null : JSON{
        return JSON.init(NSNull())
    }
    
}

extension JSON{
    
    /// Unwrap the jsonObject
    ///
    /// - Parameter object: jsonObject
    /// - Returns: unwraped jsonObject
    func unwrap(_ object : Any) -> Any {
        switch object {
        case let json as JSON:
            return unwrap(json.innerObject)
        default:
            <#code#>
        }
    }
}

