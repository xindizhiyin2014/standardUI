//
//  JKColorExtension.swift
//  JKBasicProvider_Swift
//
//  Created by JackLee on 2021/9/26.
//

import Foundation
extension UIColor {
    
    /// 十六进制数字转换为UIColor
    /// - Parameter hex: 十六进制数字
    /// - Returns: UIColor 对象
    public class func color(withHex hex:UInt) -> UIColor {
        let red = CGFloat((hex >> 16) & 0xFF)/CGFloat(0xFF)
        let green = CGFloat((hex >> 8) & 0xFF)/CGFloat(0xFF)
        let blue = CGFloat((hex >> 0) & 0xFF)/CGFloat(0xFF)
        var alpha:CGFloat = 1.0
        if hex > 0xFFFFFF {
            alpha = CGFloat((hex >> 24) & 0xFF)/CGFloat(0xFF)
        }
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// 十六进制数字转换为UIColor,可以调节透明度
    /// - Parameters:
    ///   - hex: 十六进制数字
    ///   - alpha: 透明度
    /// - Returns: UIColor 对象
    public class func color(withHex hex:UInt, alpha:CGFloat) -> UIColor {
        let red = CGFloat((hex >> 16) & 0xFF)/CGFloat(0xFF)
        let green = CGFloat((hex >> 8) & 0xFF)/CGFloat(0xFF)
        let blue = CGFloat((hex >> 0) & 0xFF)/CGFloat(0xFF)
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// css字符串转换为颜色
    /// - Parameter css: css字符串
    /// - Returns: UIColor对象
    public class func color(withCSS css:String) -> UIColor {
        if css.count == 0 {
            return .black
        }
        var a:String = ""
        var r:String = ""
        var g:String = ""
        var b:String = ""
        let count = css.count
        
        func six(_ cssString:String) {
            a = "FF"
            let index_r = cssString.index(cssString.startIndex, offsetBy: 2)
            let index_g = cssString.index(index_r, offsetBy: 2)
            let index_b = cssString.index(index_g, offsetBy: 2)
            r = String(cssString[..<index_r])
            g = String(cssString[index_r..<index_g])
            b = String(cssString[index_g..<index_b])
        }
        
        func eight (_ cssString:String) {
            let index_a = cssString.index(css.startIndex, offsetBy: 2)
            let index_r = cssString.index(index_a, offsetBy: 2)
            let index_g = cssString.index(index_r, offsetBy: 2)
            let index_b = cssString.index(index_g, offsetBy: 2)
            a = String(cssString[..<index_a])
            r = String(cssString[index_a..<index_r])
            g = String(cssString[index_r..<index_g])
            b = String(cssString[index_g..<index_b])
        }
        
        func three (_ cssString:String) {
            a = "FF"
            let index_r = cssString.index(css.startIndex, offsetBy: 1)
            let index_g = cssString.index(index_r, offsetBy: 1)
            let index_b = cssString.index(index_g, offsetBy: 1)
            r = String(cssString[..<index_r])
            r += a
            g = String(cssString[index_r..<index_g])
            g += a
            b = String(cssString[index_g..<index_b])
            b += a
        }
        if count == 6 {
            six(css)
        } else if count == 8 {
           eight(css)
        } else if count == 3 {
           three(css)
        } else if count == 4 {
            let index_a = css.index(css.startIndex, offsetBy: 1)
            let index_r = css.index(index_a, offsetBy: 1)
            let index_g = css.index(index_r, offsetBy: 1)
            let index_b = css.index(index_g, offsetBy: 1)
            a = String(css[..<index_a])
            r = String(css[index_a..<index_r])
            r += a
            g = String(css[index_r..<index_g])
            g += a
            b = String(css[index_g..<index_b])
            b += b
        } else if count == 5
                  || count == 7 {
           let cssString = "0\(css)"
            if count == 5 {
                six(cssString)
            } else {
                eight(cssString)
            }
        } else if count < 3 {
            var cssString = css
            while cssString.count < 3 {
                cssString = "0" + cssString
            }
            three(cssString)
            
        } else if count > 8 {
            let index = css.index(css.startIndex, offsetBy: count - 8)
            let cssString = String(css[index..<css.endIndex])
            eight(cssString)
        }
        a = "\(a)"
        r = "\(r)"
        g = "\(g)"
        b = "\(b)"
        let int_a:UInt = UInt(a.HexToDecimal())
        let int_r:UInt = UInt(r.HexToDecimal())
        let int_g:UInt = UInt(g.HexToDecimal())
        let int_b:UInt = UInt(b.HexToDecimal())
        let alpha = CGFloat(int_a)/CGFloat(255)
        let red = CGFloat(int_r)/CGFloat(255)
        let green = CGFloat(int_g)/CGFloat(255)
        let blue = CGFloat(int_b)/CGFloat(255)
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// css转换为UIColor,alpha
    /// - Parameters:
    ///   - css: css字符串
    ///   - alpha: 透明度
    /// - Returns: UIColor对象
    public class func color(witCSS css:String, alpha:CGFloat) -> UIColor {
        if css.count == 0 {
            return .black
        }
        var a:String = ""
        var r:String = ""
        var g:String = ""
        var b:String = ""
        let count = css.count
        
        func six(_ cssString:String) {
            a = "FF"
            let index_r = cssString.index(cssString.startIndex, offsetBy: 2)
            let index_g = cssString.index(index_r, offsetBy: 2)
            let index_b = cssString.index(index_g, offsetBy: 2)
            r = String(cssString[..<index_r])
            g = String(cssString[index_r..<index_g])
            b = String(cssString[index_g..<index_b])
        }
        
        func eight (_ cssString:String) {
            let index_a = cssString.index(css.startIndex, offsetBy: 2)
            let index_r = cssString.index(index_a, offsetBy: 2)
            let index_g = cssString.index(index_r, offsetBy: 2)
            let index_b = cssString.index(index_g, offsetBy: 2)
            a = String(cssString[..<index_a])
            r = String(cssString[index_a..<index_r])
            g = String(cssString[index_r..<index_g])
            b = String(cssString[index_g..<index_b])
        }
        
        func three (_ cssString:String) {
            a = "FF"
            let index_r = cssString.index(css.startIndex, offsetBy: 1)
            let index_g = cssString.index(index_r, offsetBy: 1)
            let index_b = cssString.index(index_g, offsetBy: 1)
            r = String(cssString[..<index_r])
            r += a
            g = String(cssString[index_r..<index_g])
            g += a
            b = String(cssString[index_g..<index_b])
            b += a
        }
        if count == 6 {
            six(css)
        } else if count == 8 {
           eight(css)
        } else if count == 3 {
           three(css)
        } else if count == 4 {
            let index_a = css.index(css.startIndex, offsetBy: 1)
            let index_r = css.index(index_a, offsetBy: 1)
            let index_g = css.index(index_r, offsetBy: 1)
            let index_b = css.index(index_g, offsetBy: 1)
            a = String(css[..<index_a])
            r = String(css[index_a..<index_r])
            r += a
            g = String(css[index_r..<index_g])
            g += a
            b = String(css[index_g..<index_b])
            b += b
        } else if count == 5
                  || count == 7 {
           let cssString = "0\(css)"
            if count == 5 {
                six(cssString)
            } else {
                eight(cssString)
            }
        } else if count < 3 {
            var cssString = css
            while cssString.count < 3 {
                cssString = "0" + cssString
            }
            three(cssString)
            
        } else if count > 8 {
            let index = css.index(css.startIndex, offsetBy: count - 8)
            let cssString = String(css[index..<css.endIndex])
            eight(cssString)
        }
        r = "\(r)"
        g = "\(g)"
        b = "\(b)"
        let int_r:UInt = UInt(r.HexToDecimal())
        let int_g:UInt = UInt(g.HexToDecimal())
        let int_b:UInt = UInt(b.HexToDecimal())
        let red = CGFloat(int_r)/CGFloat(255)
        let green = CGFloat(int_g)/CGFloat(255)
        let blue = CGFloat(int_b)/CGFloat(255)
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// UIColor转hex值
    /// - Returns: hex值
    public func hex() ->UInt {
        var red:CGFloat = CGFloat.init()
        var green:CGFloat = CGFloat.init()
        var blue:CGFloat = CGFloat.init()
        var alpha:CGFloat = CGFloat.init()
        let result = getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        if result == false {
            getWhite(&red, alpha: &alpha)
            green = red
            blue = red
        }
        red = CGFloat(roundf(Float(red) * Float(255)))
        green = CGFloat(roundf(Float(green) * Float(255)))
        blue = CGFloat(roundf(Float(blue) * Float(255)))
        alpha = CGFloat(roundf(Float(alpha) * Float(255)))
        return UInt(alpha) << 24 | UInt(red) << 16 | UInt(green) << 8 | UInt(blue) << 0
    }
    
    /// UIColor转hex字符串
    /// - Returns: hex字符串
    public func hexString() -> String {
        return String.init(format: "0x%08x", hex())
    }
    
    /// 转换为css字符串
    /// - Returns: css字符串
   public func cssString() -> String {
        let hexValue = hex()
        if (hexValue & 0xFF000000) == 0xFF000000 {
            return String.init(format: "#%06x", hexValue)
        }
        return String.init(format: "#%08x", hexValue)
    }
    
    
    
}
