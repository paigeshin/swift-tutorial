//
//  AnimUtils.swift
//  Tabbar
//
//  Created by shin seunghyun on 2020/02/24.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

class AnimUtils: NSObject, UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ScrollingAnim(tabBarController: tabBarController) //애니메이션을 적용해줌..
    }
    
}

//아래 애니메이션 적용
class ScrollingAnim: NSObject, UIViewControllerAnimatedTransitioning {
    
    var revser: Bool = false
    var tabBarController : UITabBarController!
    var fromIndex: Int = 0
    
    weak var transitionContext: UIViewControllerContextTransitioning?
    
    init(tabBarController: UITabBarController){
        self.tabBarController = tabBarController
        self.fromIndex = tabBarController.selectedIndex
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //뷰 만들어주기
        self.transitionContext = transitionContext
        let containerView: UIView = transitionContext.containerView
        
        //원래 뷰
        let fromView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        
        //추가될 뷰
        let toView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        //적용
        containerView.addSubview(toView!.view)
        var width = toView?.view.bounds.width
        
        //fromindex 기존 값
        //tabBarController.selectedIndex 새로 들어온 값
        if tabBarController.selectedIndex < fromIndex {
            width = -width!
        }
        
        
        toView!.view.transform = CGAffineTransform(translationX: width!, y: 0)
        UIView.animate(withDuration: self.transitionDuration(using: (self.transitionContext)), animations: {
            //입력되는 뷰
            toView?.view.transform = CGAffineTransform.identity //실제로 애니메이션을 적용
            fromView?.view.transform = CGAffineTransform(translationX: -width!, y: 0)
                    
        }, completion: { _ in
            //사라지는 뷰
            fromView?.view.transform = CGAffineTransform.identity
            self.transitionContext?.completeTransition(self.transitionContext!.transitionWasCancelled)
        })
        
    }
    
    
}
