//
//  UIViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 10/12/2020.
//

import Foundation
import UIKit

extension UIViewController {
    class var storyboardID: String {
        return "\(self)"
    }
    static func instantiate(fromAppStoryboard: AppStoryboard) -> Self {
        return fromAppStoryboard.viewController(viewControllerClass: self)
    }
    
    func showActionSheet(title: String, message: String, style: UIAlertController.Style, actions: [UIAlertAction?]) {
        let actionSheetController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions {
            if let action = action {
                actionSheetController.addAction(action)
            }
        }
        self.present(actionSheetController, animated: true, completion: nil)
    }
    func actionMessageOK(_ completion: (() -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default) { _ in
            completion?()
        }
    }
    func actionMessageCancel(_ completion: (() -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel) { _ in
            completion?()
        }
    }
    func actionMessageClose(_ completion: (() -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("close", comment: ""), style: .default) { _ in
            completion?()
        }
    }

    func actionMessageRetry(_ completion: (() -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("retry", comment: ""), style: .default) { _ in
            completion?()
        }
    }

    func actionMessage(_ title: String, style: UIAlertAction.Style, _ completion: (() -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: title, style: style) { _ in
            completion?()
        }
    }
}
