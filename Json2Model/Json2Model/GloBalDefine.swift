//
//  GloBalDefine.swift
//  Json2Model
//
//  Created by 11111 on 2017/7/17.
//  Copyright © 2017年 None. All rights reserved.
//

import UIKit

let ScreenWidth : CGFloat = UIScreen .main .bounds .size .width
let ScreenHeight : CGFloat = UIScreen .main .bounds .size .height
let ScreenHeightUnit :CGFloat = UIScreen .main .bounds .size .height * 1.000 / 667.000
let ScreenWidthUnit :CGFloat = UIScreen .main .bounds .size .width * 1.000 / 375.000

typealias swiftNoPatameterBlock = () -> Void

//颜色，Eg:ColorMethodho(0x00c18b)
func ColorMethodho(hexValue : Int) -> UIColor {
    let red   = ((hexValue & 0xFF0000) >> 16)
    let green = ((hexValue & 0xFF00) >> 8)
    let blue  = (hexValue & 0xFF)
    
    return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(1))
}

func printWithTime<T>( _ object : T) {
    let nowDate = Date.init()
    let timeFor = DateFormatter.init()
    timeFor.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    let nowDateInStr : String = timeFor.string(from: nowDate)
    
    print("\(nowDateInStr) : \(object)")
}

class GloBalDefine: NSObject {

}
