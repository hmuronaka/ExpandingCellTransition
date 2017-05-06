//
//  UITableView+ExpandingCellTransition.swift
//  ExpandingCellTransition
//
//  Created by Muronaka Hiroaki on 2017/05/05.
//  Copyright © 2017年 MuronakaHiroaki. All rights reserved.
//

import UIKit

extension UITableView {
    
    func ts_rectFromParent(at indexPath:IndexPath) -> CGRect {
        let rect = self.rectForRow(at: indexPath)
        return self.convert(rect, to: self.superview)
    }
}
