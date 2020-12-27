//
//  Utility.swift
//  ClearAsset
//
//  Created by Peyk Office on 08/12/2020.
//

import Foundation
import UIKit
import PKHUD

class Utility {
    
    struct appFont {
        static let regularFont = "Nunito-Regular"
        static let boldFont = "Nunito-Bold"
        static let semiBold = "Nunito-SemiBold"
    }
    
}

enum AppStoryboard: String {
    case Start, Login, Register, Profile, Menu, TabBar, Add
    var instance: UIStoryboard {
      return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T // swiftlint:disable:this force_cast
    }
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }

}
