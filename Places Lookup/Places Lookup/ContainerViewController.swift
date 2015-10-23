//
//  ContainerViewController.swift
//  Places Lookup
//
//  Created by Swagat Kumar Bisoyi on 10/18/15.
//  Copyright © 2015 Swagat Kumar Bisoyi. All rights reserved.
//

import UIKit
import QuartzCore

enum SlideOutState {
  case BothCollapsed
  case LeftPanelExpanded
  case RightPanelExpanded
}
var containerVC : ContainerViewController!
class ContainerViewController: UIViewController {
  
  var centerNavigationController: UINavigationController!
    

    var routeViewController: RouteViewController!
    var viewController: ViewController!
    var feedbackViewController: FeedbackViewController!
    var paymentViewController : PaymentViewController!
    
    
    var currentState: SlideOutState = .BothCollapsed {
    didSet {
      let shouldShowShadow = currentState != .BothCollapsed
      showShadowForCenterViewController(shouldShowShadow)
    }
  }
  
  var leftViewController: SidePanelViewController?

  let centerPanelExpandedOffset: CGFloat = 100
  
  override func viewDidLoad() {
    super.viewDidLoad()
    routeViewController = UIStoryboard.centerRouteViewController()
    routeViewController.delegate = self
    
    viewController = UIStoryboard.centerViewController()
    viewController.delegate = self
    
    feedbackViewController = UIStoryboard.centerFeedbackViewController()
    feedbackViewController.delegate = self
    
    paymentViewController = UIStoryboard.centerPaymentViewController()
    paymentViewController.delegate = self
    
    // wrap the centerViewController in a navigation controller, so we can push views to it
    // and display bar button items in the navigation bar
    centerNavigationController = UINavigationController(rootViewController: routeViewController)
    view.addSubview(centerNavigationController.view)
    addChildViewController(centerNavigationController)
    
    centerNavigationController.didMoveToParentViewController(self)
    containerVC = self

//    let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
//    centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
  }
  
}

// MARK: CenterViewController delegate

extension ContainerViewController: CenterViewControllerDelegate {

  func toggleLeftPanel() {
    let notAlreadyExpanded = (currentState != .LeftPanelExpanded)
    
    if notAlreadyExpanded {
      addLeftPanelViewController()
    }
    
    animateLeftPanel(shouldExpand: notAlreadyExpanded)
  }
  
  func toggleRightPanel() {
    let notAlreadyExpanded = (currentState != .RightPanelExpanded)
    
    if notAlreadyExpanded {
//      addRightPanelViewController()
    }
    
    animateRightPanel(shouldExpand: notAlreadyExpanded)
  }
  
  func collapseSidePanels() {
    switch (currentState) {
    case .RightPanelExpanded:
        print("Right")
//      toggleRightPanel()
    case .LeftPanelExpanded:
      toggleLeftPanel()
    default:
      break
    }
  }
  
  func addLeftPanelViewController() {
    if (leftViewController == nil) {
      leftViewController = UIStoryboard.leftViewController()
//      leftViewController!.animals = Animal.allCats()
      
      addChildSidePanelController(leftViewController!)
    }
  }
  
  func addChildSidePanelController(sidePanelController: SidePanelViewController) {
    sidePanelController.delegate = routeViewController
    
    view.insertSubview(sidePanelController.view, atIndex: 0)
    
    addChildViewController(sidePanelController)
    sidePanelController.didMoveToParentViewController(self)
  }
  
//  func addRightPanelViewController() {
//    if (rightViewController == nil) {
//      rightViewController = UIStoryboard.rightViewController()
//      rightViewController!.animals = Animal.allDogs()
//      
//      addChildSidePanelController(rightViewController!)
//    }
//  }
  
  func animateLeftPanel(shouldExpand shouldExpand: Bool) {
    if (shouldExpand) {
      currentState = .LeftPanelExpanded
      
      animateCenterPanelXPosition(targetPosition: CGRectGetWidth(centerNavigationController.view.frame) - centerPanelExpandedOffset)
    } else {
      animateCenterPanelXPosition(targetPosition: 0) { finished in
        self.currentState = .BothCollapsed
        
        self.leftViewController!.view.removeFromSuperview()
        self.leftViewController = nil;
      }
    }
  }
  
  func animateCenterPanelXPosition(targetPosition targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
    UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
      self.centerNavigationController.view.frame.origin.x = targetPosition
      }, completion: completion)
  }
  
  func animateRightPanel(shouldExpand shouldExpand: Bool) {
    if (shouldExpand) {
      currentState = .RightPanelExpanded
      
      animateCenterPanelXPosition(targetPosition: -CGRectGetWidth(centerNavigationController.view.frame) + centerPanelExpandedOffset)
    } else {
      animateCenterPanelXPosition(targetPosition: 0) { _ in
        self.currentState = .BothCollapsed
        
//        self.rightViewController!.view.removeFromSuperview()
//        self.rightViewController = nil;
      }
    }
  }
  
  func showShadowForCenterViewController(shouldShowShadow: Bool) {
    if (shouldShowShadow) {
      centerNavigationController.view.layer.shadowOpacity = 0.8
    } else {
      centerNavigationController.view.layer.shadowOpacity = 0.0
    }
  }
  
}

extension ContainerViewController: UIGestureRecognizerDelegate {
  // MARK: Gesture recognizer
  
  func handlePanGesture(recognizer: UIPanGestureRecognizer) {
    let gestureIsDraggingFromLeftToRight = (recognizer.velocityInView(view).x > 0)
    
    switch(recognizer.state) {
    case .Began:
      if (currentState == .BothCollapsed) {
        if (gestureIsDraggingFromLeftToRight) {
          addLeftPanelViewController()
        } else {
//          addRightPanelViewController()
        }
        
        showShadowForCenterViewController(true)
      }
    case .Changed:
      recognizer.view!.center.x = recognizer.view!.center.x + recognizer.translationInView(view).x
      recognizer.setTranslation(CGPointZero, inView: view)
    case .Ended:
      if (leftViewController != nil) {
        if (recognizer.velocityInView(view).x > 0)
        {
            // animate the side panel open or closed based on whether the view has moved more or less than halfway
            let hasMovedGreaterThanHalfway = recognizer.view!.center.x > view.bounds.size.width
            animateLeftPanel(shouldExpand: hasMovedGreaterThanHalfway)
        }
      }
//      else if (rightViewController != nil) {
//        let hasMovedGreaterThanHalfway = recognizer.view!.center.x < 0
//        animateRightPanel(shouldExpand: hasMovedGreaterThanHalfway)
//      }
    default:
      break
    }
  }
}

private extension UIStoryboard {
  class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
  
  class func leftViewController() -> SidePanelViewController? {
    return mainStoryboard().instantiateViewControllerWithIdentifier("LeftViewController") as? SidePanelViewController
  }
  class func centerRouteViewController() -> RouteViewController? {
    return mainStoryboard().instantiateViewControllerWithIdentifier("RouteViewController") as? RouteViewController
  }
    class func centerViewController() -> ViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("ViewController") as? ViewController
    }
    class func centerFeedbackViewController() -> FeedbackViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("FeedbackViewController") as? FeedbackViewController
    }
    class func centerPaymentViewController() -> PaymentViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("PaymentViewController") as? PaymentViewController
    }
    
    

  
}