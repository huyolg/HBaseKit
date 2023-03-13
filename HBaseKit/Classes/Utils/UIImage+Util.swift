//
//  UIImage+Util.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/13.
//


import UIKit

extension UIImage {
    //    MARK:  重绘image
    func resizeImageToSize(_ size: CGSize) -> UIImage? {
        var resizeImage: UIImage?
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size), blendMode: .copy, alpha: 1)
        resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizeImage
    }
    
    //    根据左边，获取对应位置图片
    func rerenderImage(_ rect: CGRect) -> UIImage? {
        let imageRef = self.cgImage
        guard let subImageRef = imageRef?.cropping(to: rect) else { return self }
        let image = UIImage(cgImage: subImageRef)
        return image
    }
    
    func recountSize(viewH: CGFloat, viewW:CGFloat) -> CGSize {
        let imageSize = self.size
        let imageW_HPer = imageSize.width / imageSize.height
        let viewW_HPer = viewW / viewH
        
        let calcViewHeight = viewW / imageW_HPer
        
        var boardSize = CGSize(width: viewW, height: calcViewHeight)
        return boardSize
    }
    
    func crop(_ rect: CGRect) -> UIImage? {
//        var newRect = rect
//        newRect.origin.x *= scale
//        newRect.origin.y *= scale
//        newRect.size.width *= scale
//        newRect.size.height *= scale
        
        guard let imageRef = self.cgImage?.cropping(to: rect) else { return nil }
        let img = UIImage(cgImage: imageRef, scale: 1.0, orientation: imageOrientation)
        return img
    }
        
    func resize(_ size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
        
    func scaleToFitAtCenter(size: CGSize) -> UIImage? {
        print(self.size)
        let scaleW_H = size.width / size.height
        let selfScaleW_H = self.size.width / self.size.height
            
        if selfScaleW_H > scaleW_H {
            let w = self.size.height * scaleW_H
            let h = self.size.height
            let x = (self.size.width - w) / 2.0
            let y: CGFloat = 0
            return self.crop(CGRect(x: x, y: y, width: w, height: h))?.resize(size)
        } else {
            let w = self.size.width
            let h = self.size.width / scaleW_H
            let x: CGFloat = 0
            let y = (self.size.height - h) / 2.0
            return self.crop(CGRect(x: x, y: y, width: w, height: h))?.resize(size)
        }
    }
}
