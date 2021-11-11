//
//  JKImageExtension.swift
//  JKBasicProvider_Swift
//
//  Created by JackLee on 2021/9/26.
//

import Foundation
extension UIImage {
    
    /// 创建水平渐变色图片
    /// - Parameters:
    ///   - colors: 颜色数组
    ///   - size: 图片尺寸
    /// - Returns: UIImage 对象
    public class func jk_horizontallyImage(withColors colors:Array<UIColor>, size:CGSize) -> UIImage? {
        let cgColors = colors.map { color in
            return color.cgColor
        }
        UIGraphicsBeginImageContextWithOptions(size, true, 1.0)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        //使用rgb颜色空间
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        //每组颜色所在位置（范围0~1)
        let locations:[CGFloat] = colors.map { color in
            return 1.0/CGFloat(colors.count)
        }
        //生成渐变色（count参数表示渐变个数）
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: locations) else {
            UIGraphicsEndImageContext()
            return nil
        }
        
        //渐变开始位置
        let start = CGPoint(x: 0, y: 0)
        //渐变结束位置
        let end = CGPoint(x: size.width, y: 0)
        //绘制渐变
        context.drawLinearGradient(gradient, start: start, end: end,
                                   options: [.drawsBeforeStartLocation,.drawsAfterEndLocation])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 创建垂直方向渐变色的图片
    /// - Parameters:
    ///   - colors: 颜色数组
    ///   - size: 图片尺寸
    /// - Returns: UIImage 对象
    public class func jk_verticallyImage(withColors colors:Array<UIColor>, size:CGSize) -> UIImage? {
        let cgColors = colors.map { color in
            return color.cgColor
        }
        UIGraphicsBeginImageContextWithOptions(size, true, 1.0)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        //使用rgb颜色空间
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        //每组颜色所在位置（范围0~1)
        let locations:[CGFloat] = colors.map { color in
            return 1.0/CGFloat(colors.count)
        }
        //生成渐变色（count参数表示渐变个数）
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: locations) else {
            UIGraphicsEndImageContext()
            return nil
        }
        
        //渐变开始位置
        let start = CGPoint(x: 0, y: 0)
        //渐变结束位置
        let end = CGPoint(x: 0, y: size.height)
        //绘制渐变
        context.drawLinearGradient(gradient, start: start, end: end,
                                   options: [.drawsBeforeStartLocation,.drawsAfterEndLocation])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 根据颜色创建图片，默认1像素的宽高
    /// - Parameter color: 颜色
    /// - Returns: UIImage 对象
    public class func jk_image(withColor color:UIColor) -> UIImage? {
        jk_image(withColor: color, size: CGSize.init(width: 1.0, height: 1.0))
    }
    
    /// 根据颜色创建图片，指定尺寸
    /// - Parameters:
    ///   - color: 颜色
    ///   - size: 图片的尺寸
    /// - Returns: UIImage 对象
    public class func jk_image(withColor color:UIColor, size:CGSize) -> UIImage? {
        let rect:CGRect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContext? = UIGraphicsGetCurrentContext()
        if context == nil {
            UIGraphicsEndImageContext()
            return nil
        }
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 从视图中获取图片
    /// - Parameter view: 视图
    /// - Returns: UIImage 对象
    public class func jk_image(fromView view:UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 1.0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        view.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 对图片进行缩放
    /// - Parameter targetSize: 目标的尺寸
    /// - Returns: UIImage 对象
    public func jk_scaleImage(with targetSize:CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(targetSize)
        self.draw(in: CGRect.init(x: 0, y: 0, width: targetSize.width, height: targetSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// 对图片机型裁剪
    /// - Parameter rect: 目标尺寸
    /// - Returns: UIImage对象
    public func jk_tailorImage(to rect:CGRect) -> UIImage? {
        guard let imageRef = self.cgImage?.cropping(to: rect) else {
            return nil
        }
        let newImage = UIImage.init(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        return newImage
    }
    
    /// 修改图片的填充色
    /// - Parameter tintColor: 填充色
    /// - Returns: UIImage 对象
    public func jk_image(with tintColor:UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
        tintColor.setFill()
        let bounds = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(bounds)
        self.draw(in: bounds, blendMode: .overlay, alpha: 1.0)
        self.draw(in: bounds, blendMode: .destinationIn, alpha: 0.1)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage
    }
    
    /// 彩色照片转换为黑白图片
    /// - Returns: UIImage对象
    public func jk_grayImage() -> UIImage? {
        let width:Int = Int(self.size.width)
        let height:Int = Int(self.size.height)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let context:CGContext? = CGContext.init(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGBitmapInfo.alphaInfoMask.rawValue)
        if context == nil {
            return nil
        }
        if self.cgImage == nil {
            return nil
        }
        context!.draw(self.cgImage!, in: CGRect.init(x: 0, y: 0, width: width, height: height))
        let cgImage = context!.makeImage()
        if cgImage == nil {
            return nil
        }
        let grayImage = UIImage.init(cgImage: cgImage!)
        return grayImage
    }
    
    /// 图片强制从右向左翻转
    /// - Returns: UIImage 对象
    public func jk_imageFlippedRightToLeft() -> UIImage? {
        if #available(iOS 9.0,*) {
            self.imageFlippedForRightToLeftLayoutDirection()
        }
        if self.cgImage == nil {
            return nil
        }
        return UIImage.init(cgImage: self.cgImage!, scale: self.scale, orientation: .upMirrored)
    }
    
    /// 根据layout方向决定是否从右向左翻转
    /// - Returns: UIImage 对象
    public func jk_imageFlippedRightToLeftIfNeeded() -> UIImage? {
        if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft {
           return jk_imageFlippedRightToLeft()
        }
        return self
    }
    
}
