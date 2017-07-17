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
            self.init(jsonObject: responseObject)
        }
    }

    fileprivate init(jsonObject : Any) {
        self.innerObject = jsonObject
    }
    
    
    /// Inner objects
    fileprivate var innerArr : [Any] = []
    fileprivate var innerDic : [String : Any] = [:]
    fileprivate var innerString : String = ""
    fileprivate var innerNumber : NSNumber = 0
    fileprivate var innerNull : NSNull = NSNull()
    fileprivate var innerBool : Bool = false
    
    /// The tyoe of JSON
    var type : Type = .null
    
    /// InnerObject in JSON
    var innerObject : Any{
        get{
            switch self.type {
            case .array:
                return self.innerArr
            case .dictionary:
                return self.innerDic
            case .string:
                return self.innerString
            case .number:
                return self.innerNumber
            case .bool:
                return self.innerBool
            default:
                return self.innerNull
            }
        }
        set{
            switch unwrap(newValue) {
            case let number as NSNumber:
                if number.isBool {
                    type = .bool
                    self.innerBool = number.boolValue
                }else{
                    type = .number
                    self.innerNumber = number
                }
            case let string as String:
                type = .string
                self.innerString = string
            case _ as NSNull:
                type = .null
            case nil:
                type = .null
            case let array as [Any]:
                type = .array
                self.innerArr = array
            case let dic as [String : Any]:
                type = .dictionary
                self.innerDic = dic
            default:
                type = .unknown
            }
        }
    }
    
    
    /// Static null JSON
    static var null : JSON{
        return JSON.init(NSNull())
    }
    
}

extension JSON{
    
    /// Unwrap the jsonObject
    ///
    /// Impossible though it seems,this method may trigger stack overflow,where the object nests deeply enough.
    /// But in RELEASE,stack overflow won't appear,with tail recursion
    ///
    /// - Parameter object: jsonObject
    /// - Returns: unwraped jsonObject
    func unwrap(_ object : Any) -> Any {
        
        func unwrapInternal(_ InnerObject : Any) -> Any{
            switch InnerObject {
            case let json as JSON:
                return unwrapInternal(json)
            case let array as [Any]:
                return array.map({
                    unwrapInternal($0)
                })
            case let dic as [String : Any]:
                var unwrapDic = dic
                for (k,v) in dic {
                    unwrapDic[k] = unwrapInternal(v)
                }
                return unwrapDic
            default:
                return InnerObject
            }
        }
        
        return unwrapInternal(object)
    }
}

extension JSON{
    
    var jsonArr : [JSON]{
        if self.type == .array {
            
            let arrWithinJSON = self.innerArr.map({ (object) -> JSON in
                return JSON.init(object)
            })
            
            return arrWithinJSON
        }else{
            return []
        }
    }
}

extension JSON{
    
    var jsonDic : [String : JSON] {
        if  self.type == .dictionary {
            var dicWithJSON = [String : JSON].init(minimumCapacity: self.innerDic.count)
            for (key,value) in self.innerDic {
                dicWithJSON.updateValue(JSON.init(value), forKey: key)
            }
            return dicWithJSON
        }else{
            return [:]
        }
    }
}

extension NSNumber{
    fileprivate var isBool : Bool{
        return false
    }
}
