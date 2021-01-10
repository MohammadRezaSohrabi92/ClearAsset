//
//  BaseViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 12/12/2020.
//

import UIKit

class BaseViewController: UIViewController {
    
    var scrollView: UIScrollView?
    var activeField : UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavigationView()
        setupBackButton()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    fileprivate func initView() {
        hideKeyboardWhenTappedAround()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    public func initScrollView(_ scrollView: UIScrollView) {
        self.scrollView = scrollView
    }
    
    fileprivate func setupNavigationView() {
        navigationController?.navigationBar.tintColor = UIColor.appBlueColor
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: Utility.appFont.semiBold, size: 19)!, NSAttributedString.Key.foregroundColor : UIColor.appBlueColor!]
    }
    
    fileprivate func setupBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(onTapBackButton(_:)))
    }
    
    @objc func onTapBackButton(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setTitle(title: String) {
        navigationController?.title = title
        navigationController?.navigationItem.title = title
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification : Notification){
        guard let keyboardInfo = notification.userInfo else {return}
        if let keyboardSize = (keyboardInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size {
            let keyboardHeight = keyboardSize.height + 10
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            self.scrollView?.contentInset = contentInsets
            var viewRect = self.view.frame
            viewRect.size.height -= keyboardHeight
            guard let activeField = self.activeField else {return}
            if (!viewRect.contains(activeField.frame.origin)) {
                let scrollPoint = CGPoint(x: 0, y: activeField.frame.origin.y - keyboardHeight)
                self.scrollView?.setContentOffset(scrollPoint, animated: true )
            }
        }
    }
    
    @objc func keyboardWillHide(notification : Notification){
        let contentInsets = UIEdgeInsets.zero
        self.scrollView?.contentInset = contentInsets
    }

}

extension BaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }        
}
