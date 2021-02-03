//
//  Utility.swift
//  ClearAsset
//
//  Created by Peyk Office on 08/12/2020.
//

import Foundation
import UIKit
import PKHUD
import SystemConfiguration

class Utility : UIViewController {
    
    struct appFont {
        static let regularFont = "Nunito-Regular"
        static let boldFont = "Nunito-Bold"
        static let semiBold = "Nunito-SemiBold"
    }
    
    class func showHudLoading() {
        HUD.show(.labeledProgress(title: "", subtitle: ""))
    }
    class func showHudLoading(title: String, message: String) {
        HUD.show(.labeledProgress(title: title, subtitle: message))
    }
    class func hideSuccessHudLoading() {
        HUD.flash(.success, delay: 1.0)
    }
    class func hideHudLoading() {
        HUD.hide()
    }
    
    class func showProgress() {
        HUD.flash(.progress, delay: 1.0)
    }
    
    func validatePhoneNumber(value: String) -> Bool {
        let phoneRegex = "(^(09|9)[0-9][0-9]\\d{7}$)|(^(09|9)[3][12456]\\d{7}$)"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        guard let defReachibility = defaultRouteReachability else {
            return false
        }
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defReachibility, &flags) == false {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        return ret
    }
    func saveData(inUserDefulat storeObject: Any?, keyOfUserDefault key: String?) {
        let prefs = UserDefaults.standard
        prefs.set(storeObject, forKey: key ?? "")
    }
    func reteriveData(inUserDefulat key: String?) -> Any? {
        let prefs = UserDefaults.standard
        let storedObject = prefs.value(forKey: key ?? "")
        return storedObject
    }
    
    func getToken() -> String {
        return reteriveData(inUserDefulat: "token") as! String
    }
    
    //image
    var imagePicker : UIImagePickerController!
    
    func setDelegateForImagePicker(delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = delegate
    }
    
    @objc func getImage(_ sender: UITapGestureRecognizer) {
        let camera = UIAlertAction(title: "Camera", style: .default) { (_) in
            self.getImageFromCamera()
        }
        let library = UIAlertAction(title: "Photo Library", style: .default) { (_) in
            self.getImageFromLibrary()
        }
        self.showActionSheet(title: "Select Photo", message: "Upload your profile image", style: .actionSheet, actions: [camera, library, actionMessageCancel()])
    }
    func getImageFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    func getImageFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            imagePicker.cameraDevice = .front
            imagePicker.showsCameraControls = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
}

enum AppStoryboard: String {
    case Start, Login, Register, Profile, Menu, TabBar, Services, Add, WatchList, Notification, Filter, ProductList, Sort, Product, BottomSheet
    
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
