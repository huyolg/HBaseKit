//
//  NSString+Util.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/13.
//

import UIKit

extension String {
    func getTextRectSize(_ font:UIFont,size:CGSize) -> CGSize {
                
         let attributes = [NSAttributedString.Key.font: font]
                
         let option = NSStringDrawingOptions.usesLineFragmentOrigin
                
         let rect:CGRect = self.boundingRect(with: size, options: option,
                      attributes: attributes, context: nil)
                
        return rect.size;
     }
}
