//
//  UIView+Bounds.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/12.
//

import UIKit

extension UIView {
    //x
    var x:Double {
        set{
            var oldFrame = self.frame
            oldFrame.origin.x = newValue;
            self.frame = oldFrame
        }
        get{
            return self.frame.origin.x
        }
    }
        //y
    var y:Double {
        set{
            var oldFrame = self.frame
            oldFrame.origin.y = newValue;
            self.frame = oldFrame
        }
        get{
            return self.frame.origin.y
        }
    }
        //height
    var height:Double {
        set{
            var oldFrame = self.frame
            oldFrame.size.height = newValue;
            self.frame = oldFrame
        }
        get{
            return self.frame.size.height
        }
    }
        //width
    var width:Double {
        set{
            var oldFrame = self.frame
            oldFrame.size.width = newValue;
            self.frame = oldFrame
        }
        get{
            return self.frame.size.width
        }
    }
        //top
    var top:Double {
        set{
            var oldFrame = self.frame
            oldFrame.origin.y = newValue;
            self.frame = oldFrame
        }
        get{
            return self.frame.origin.y
        }
    }
        //left
    var left:Double {
        set{
            var oldFrame = self.frame
            oldFrame.origin.x = newValue;
            self.frame = oldFrame
        }
        get{
            return self.frame.origin.x
        }
    }
        //bottom
    var bottom:Double {
        set{
            var oldFrame = self.frame
            oldFrame.origin.y = newValue - oldFrame.size.height;
            self.frame = oldFrame
        }
        get{
            return self.frame.origin.y + self.frame.size.height
        }
    }
        //right
    var right:Double {
        set{
            var oldFrame = self.frame
            oldFrame.origin.x = newValue+oldFrame.size.width;
            self.frame = oldFrame
        }
        get{
            return self.frame.origin.x + self.frame.size.width
        }
    }
        //size
    var size:CGSize {
        set{
            var oldFrame = self.frame
            oldFrame.size = newValue
            self.frame = oldFrame
        }
        get{
            return self.frame.size
        }
    }
        //origin
    var origin: CGPoint{
        set{
            var oldFrame = self.frame
            oldFrame.origin = newValue;
            self.frame = oldFrame
        }
        get{
            return self.frame.origin
        }
    }
}
