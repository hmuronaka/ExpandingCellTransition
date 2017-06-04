//
//  ExpandingCellTransition.swift
//  ExpandingCellTransition
//
//  Created by MuronakaHiroaki on 2017/05/05.
//  Copyright © 2017年 MuronakaHiroaki. All rights reserved.
//

import UIKit

open class ExpandingCellTransition: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    fileprivate enum PresentationStyle {
        case present, dismiss
    }
    
    public fileprivate(set) var duration:TimeInterval
    public fileprivate(set) var tableView: UITableView!
    fileprivate var presentationStyle:PresentationStyle = .present
    
    public var tappedCellIndex:IndexPath?
    
    public init(tableView:UITableView, duration: TimeInterval = 0.5) {
        self.duration = duration
        self.tableView = tableView
    }
    
    
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let tappedCellIndex = tappedCellIndex else {
            return
        }
        
        
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let toViewControllerFinalFrame = transitionContext.finalFrame(for: toViewController!)
        
        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!
        
        let parentViewOfTableView:UIView! = (self.presentationStyle == .present ? fromView : toView)
        let tableViewImage = parentViewOfTableView.ts_toImage()
        
        // 親ビューからのtableViewの相対座標を取得する。
        let tableViewFrame = tableView.convert(tableView.bounds, to: parentViewOfTableView)
        // tableViewからのタップされたセルの座標を取得する。
        var tappedCellRect = tableView.ts_rectFromParent(at: tappedCellIndex)
        // 親ビューからのcellの座標を取得する。
        tappedCellRect.origin.y += tableViewFrame.origin.y
        
        // top rect
        let fromTopRect = CGRect(x: 0, y: 0, width: fromView.frame.width, height: tappedCellRect.origin.y)
        let toTopRect = CGRect(x: 0, y: -fromTopRect.height, width: fromView.frame.width, height: fromTopRect.height)
        let topViewImage = tableViewImage.ts_crop(rect: fromTopRect)
        
        // cell rect
        let fromCellRect = tappedCellRect
        let toCellRect = CGRect(x: 0, y: 0, width: fromView.frame.width, height: fromCellRect.height)
        let cellImage = tableViewImage.ts_crop(rect: tappedCellRect)
        
        // bottom rect
        let fromBottomRect = CGRect(x: 0, y: tappedCellRect.origin.y + tappedCellRect.height, width: fromView.frame.width, height: fromView.frame.height - fromTopRect.height - tappedCellRect.height)
        let toBottomRect = CGRect(x: 0, y: fromView.frame.height, width: tappedCellRect.width, height: fromBottomRect.height)
        let bottomViewImage = tableViewImage.ts_crop(rect: fromBottomRect)
        
        let topImageView = UIImageView(image: topViewImage)
        let bottomImageView = UIImageView(image: bottomViewImage)
        let cellImageView = UIImageView(image: cellImage)
        
        let containerView = transitionContext.containerView
        
        switch presentationStyle {
        case .present:
            cellImageView.frame = fromCellRect
            bottomImageView.frame = fromBottomRect
            
            toView.frame = tappedCellRect
            toView.alpha = 0.90
            containerView.addSubview(cellImageView)
            containerView.addSubview(toView)
            containerView.addSubview(topImageView)
            containerView.addSubview(bottomImageView)
            
            fromView.removeFromSuperview()
            
            UIView.animate(withDuration: duration, animations: {
                topImageView.frame = toTopRect
                bottomImageView.frame = toBottomRect
                cellImageView.frame = toCellRect
                cellImageView.alpha = 0.0
                fromView.alpha = 0.0
                toView.frame = toViewControllerFinalFrame
                toView.alpha = 1.0
            }) { [unowned self] isFinish in
                if isFinish {
                    containerView.addSubview(toView)
                    topImageView.removeFromSuperview()
                    bottomImageView.removeFromSuperview()
                    cellImageView.removeFromSuperview()
                    fromView.alpha = 1.0
                    transitionContext.completeTransition(true)
                    self.presentationStyle = .dismiss
                }
            }
        case .dismiss:
            
            let fromViewImage = fromView.ts_toImage()
            let imageView = UIImageView(image: fromViewImage)
            imageView.contentMode = .topLeft
            containerView.addSubview(imageView)
            fromView.removeFromSuperview()
            
            topImageView.frame = toTopRect
            bottomImageView.frame = toBottomRect
            cellImageView.frame = toCellRect
            
            containerView.addSubview(topImageView)
            containerView.addSubview(bottomImageView)
            containerView.addSubview(cellImageView)
            
            toView.frame = toViewControllerFinalFrame
            cellImageView.alpha = 0.0
            
            UIView.animate(withDuration: self.duration, animations: {
                imageView.frame = tappedCellRect
                topImageView.frame = fromTopRect
                bottomImageView.frame = fromBottomRect
                cellImageView.frame = fromCellRect
                imageView.alpha = 5.0
                cellImageView.alpha = 1.0
            }) { [unowned self] isFinish in
                containerView.addSubview(toView)
                topImageView.removeFromSuperview()
                bottomImageView.removeFromSuperview()
                cellImageView.removeFromSuperview()
                imageView.removeFromSuperview()
                transitionContext.completeTransition(true)
                self.presentationStyle = .present
            }
        }
    }
}
