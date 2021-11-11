//
//  JKStringExtension.swift
//  JKBasicProvider_Swift
//
//  Created by JackLee on 2021/9/26.
//

import Foundation

//MARK:进制转换
public extension String{
    //二进制转十进制
   func BinaryToDecimal() -> Int {
       var sum:Int = 0
       for c in self {
           if let number = Int(String(c))
           {
               sum = sum * 2 + number
           }
       }
       return sum
   }

    //八进制转十进制
    func OctalToDecimal() -> Int {
           var sum:Int = 0
           for c in self {
               if let number = Int(String(c))
               {
                   sum = sum * 8 + number
               }
           }
           return sum
       }

    //十六进制转十进制
    func HexToDecimal() -> Int {
           var sum:Int = 0
        let str:String = self.uppercased()
        for i in str.utf8 {
            //0-9：从48开始
            sum = sum * 16 + Int(i) - 48
            //A-Z：从65开始
            if i >= 65 {
                sum -= 7
            }
        }
           return sum
       }
}
