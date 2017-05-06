//
//  UIImage+ExpandingCellTransition.swift
//  ExpandingCellTransition
//
//  Created by Muronaka Hiroaki on 2017/05/05.
//  Copyright © 2017年 MuronakaHiroaki. All rights reserved.
//

import UIKit

extension UIImage {
    
    func ts_crop(rect: CGRect) -> UIImage? {
        
        var cropRect = rect
        cropRect.origin.x *= UIScreen.main.scale
        cropRect.origin.y *= UIScreen.main.scale
        cropRect.size.width *= UIScreen.main.scale
        cropRect.size.height *= UIScreen.main.scale
        
        guard let imageRef = self.cgImage!.cropping(to: cropRect) else {
            return nil
        }
        return UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
    }
    
}
