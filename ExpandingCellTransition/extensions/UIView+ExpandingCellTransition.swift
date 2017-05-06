//
//  UIView+ExpandingCellTransition.swift
//  ExpandingCellTransition
//
//  Created by MuronakaHiroaki on 2017/05/05.
//  Copyright © 2017年 MuronakaHiroaki. All rights reserved.
//

import UIKit

extension UIView {

    func ts_toImage(opaque:Bool = true) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, opaque, 0);
        
        let context = UIGraphicsGetCurrentContext()!
        
        // 透明にする場合, contextを変更するのでsaveしておく。
        if !opaque {
            context.saveGState()
            UIColor.clear.set()
        }
        self.layer.render(in: context)
        
        let image:UIImage! = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        if !opaque {
            context.restoreGState()
        }
        
        return image;
    }

}
