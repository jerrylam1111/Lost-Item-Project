//
//  ContainerViewController.swift
//  Lost Item Project
//
//  Created by Hei Lok Keith Kong on 13/9/2022.
//

/*
 Main class of the project
 Holds "HomeViewController" which switches over different scenes
 Holds "SideViewController" which is the side menu
 */

import UIKit

class ContainerViewController: UIViewController {
    
    var homeNavigationController:UINavigationController!
    var isExpanded:Bool = false {
        // whenever side menu is expanded or collapse
        didSet {
            showShadowForHomeViewController(isExpanded)
        }
    }
    var centerPanelExpandedOffset: CGFloat = 90.0 // how much view is left when side menu opens

    var homeViewController: HomeViewController!
    var sideViewController: SideViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get navigation controller and HomeViewController from storyboard
        homeNavigationController = UIStoryboard.homeNavigationController()
        homeViewController = homeNavigationController.topViewController as? HomeViewController
        homeViewController.delegate = self
        view.addSubview(homeNavigationController.view)
        addChild(homeNavigationController)
        homeNavigationController.didMove(toParent: self)
        // Add Gesture Recognizer to HomeViewController (swipe action)
        let panGestureRecognizer = UIPanGestureRecognizer(
          target: self,
          action: #selector(handlePanGesture(_:)))
        homeNavigationController.view.addGestureRecognizer(panGestureRecognizer)
    }
}

private extension UIStoryboard {
    // Allias Helper functions
    static func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
    
    static func homeNavigationController() -> UINavigationController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "HomeNavigationController") as? UINavigationController
    }
        
    static func sideViewController() -> SideViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "SideViewController") as? SideViewController
    }
}

extension ContainerViewController: HomeViewControllerDelegate{
    
    func toggleSideView() {
        if !isExpanded {
            addSideViewToController()
        }
        animateSideView(shouldExpand:!isExpanded)
    }
    
    func addSideViewToController() {
        // only add if sideViewController not exist
        guard sideViewController == nil else { return }
        
        if let vc = UIStoryboard.sideViewController() {
            addChildSideViewController(vc)
            sideViewController = vc
        }
    }
    
    func animateSideView(shouldExpand: Bool) {
        if shouldExpand {
            isExpanded = true
            animateHomeViewControllerXPosition(
                targetPosition: homeNavigationController.view.frame.width
                - centerPanelExpandedOffset)
        } else { // collapse side menu
            animateHomeViewControllerXPosition(targetPosition: 0) { _ in
                self.isExpanded = false
                self.sideViewController?.view.removeFromSuperview()
                self.sideViewController = nil
            }
        }
    }
    
    // when side menu appear/collapse, home view needs to move accordingly
    func animateHomeViewControllerXPosition(
        targetPosition: CGFloat,
        completion: ((Bool) -> Void)? = nil) {
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0,
                options: .curveEaseInOut,
                animations: {
                    self.homeNavigationController.view.frame.origin.x = targetPosition
                },
                completion: completion)
        }
    
    // add a subview from a View Controller to another View Controller
    func addChildSideViewController(_ sideViewController:SideViewController) {
        view.insertSubview(sideViewController.view, at: 0)
        addChild(sideViewController)
        sideViewController.didMove(toParent: self)
    }
    
    // for aesthetic purposes only
    func showShadowForHomeViewController(_ shouldShowShadow: Bool) {
        homeNavigationController.view.layer.masksToBounds = false
        homeNavigationController.view.layer.shadowColor = UIColor.black.cgColor
        homeNavigationController.view.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        homeNavigationController.view.layer.shadowRadius = 10
      if shouldShowShadow {
          homeNavigationController.view.layer.shadowOpacity = 0.8
      } else {
          homeNavigationController.view.layer.shadowOpacity = 0.0
      }
    }
}

// Swipe Gesture Recognizor
extension ContainerViewController:UIGestureRecognizerDelegate {
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
            
        // 1: during the swipe
        case .changed:
          // show side menu if not yet shown
          if !isExpanded {
            addSideViewToController()
            showShadowForHomeViewController(true)
          }
          // update position of home view in real time
          if let rview = recognizer.view {
              rview.center.x = max(view.bounds.size.width / 2, rview.center.x + recognizer.translation(in: view).x)
            recognizer.setTranslation(CGPoint.zero, in: view)
          }

        // 2: after the swipe
        case .ended:
          if let _ = sideViewController,
            let rview = recognizer.view {
            // animate the side panel open or closed based on whether the view
            // has moved more or less than halfway
            let hasMovedGreaterThanHalfway = rview.center.x > view.bounds.size.width
            animateSideView(shouldExpand: hasMovedGreaterThanHalfway)
          }
        default:
          break
        }

    }
}
