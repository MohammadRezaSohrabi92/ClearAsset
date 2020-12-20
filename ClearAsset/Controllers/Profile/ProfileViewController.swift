//
//  ProfileViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 14/12/2020.
//

import UIKit

class ProfileViewController: BaseViewController, UINavigationControllerDelegate {
    
    //MARK:- views
    @IBOutlet weak var name: CustomLabel!
    @IBOutlet weak var email: CustomLabel!
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var imageContainer: UIView!
    
    
    //MARK:- init var
    let accountCellIdentifier = "accountCellIdentifier"
    let signinInfoCellIdentifier = "siginInfoCellIdentifier"
    let manageAccount = "manageAccountIdentifier"
    struct TableData {
        var isExpanded: Bool
        var title: String
    }
    var dataForTable = [TableData]()
    var imagePicker = UIImagePickerController()

    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    //MARK:- ohter methods
    fileprivate func initViews() {
        mainTable.register(UINib(nibName: "MyAccountCell", bundle: nil), forCellReuseIdentifier: accountCellIdentifier)
        mainTable.register(UINib(nibName: "SignInInfoCell", bundle: nil), forCellReuseIdentifier: signinInfoCellIdentifier)
        mainTable.register(UINib(nibName: "ManageAccount", bundle: nil), forCellReuseIdentifier: manageAccount)
        dataForTable = [TableData(isExpanded: true, title: "My Account"),
                        TableData(isExpanded: true, title: "Sign In Information"),
                        TableData(isExpanded: true, title: "Manage Account")]
        mainTable.refreshControl?.isEnabled = false
        imageContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(getImageProfileUser(_:))))
    }
    
    @objc func getImageProfileUser(_ sender: UITapGestureRecognizer) {
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
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    func getImageFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            imagePicker.cameraDevice = .front
            imagePicker.showsCameraControls = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
}

    //MARK:- tableView delegate and data source
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataForTable.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: accountCellIdentifier, for: indexPath) as? MyAccountCell {
                return cell
            }
        } else if indexPath.section == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: signinInfoCellIdentifier, for: indexPath) as? SignInInfoCell {
                return cell
           }
        } else if indexPath.section == 2 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: manageAccount, for: indexPath) as? ManageAccount {
                return cell
            }
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MyAccountCell {
            UIView.animate(withDuration: 0.3) {
                cell.bottomView.isHidden = !cell.bottomView.isHidden
                tableView.rowHeight = 65
                self.dataForTable[indexPath.section].isExpanded = !self.dataForTable[indexPath.section].isExpanded
            }
            tableView.beginUpdates()
            tableView.endUpdates()
            tableView.deselectRow(at: indexPath, animated: true)
        }
        if let cell = tableView.cellForRow(at: indexPath) as? SignInInfoCell {
            UIView.animate(withDuration: 0.3) {
                cell.bottomView.isHidden = !cell.bottomView.isHidden
                tableView.rowHeight = 65
                self.dataForTable[indexPath.section].isExpanded = !self.dataForTable[indexPath.section].isExpanded
            }
            tableView.beginUpdates()
            tableView.endUpdates()
            tableView.deselectRow(at: indexPath, animated: true)
        }
        if let cell = tableView.cellForRow(at: indexPath) as? ManageAccount {
            UIView.animate(withDuration: 0.3) {
                cell.bottomView.isHidden = !cell.bottomView.isHidden
                tableView.rowHeight = 65
                self.dataForTable[indexPath.section].isExpanded = !self.dataForTable[indexPath.section].isExpanded
            }
            tableView.beginUpdates()
            tableView.endUpdates()
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dataForTable[indexPath.section].isExpanded {
            return 75
        } else {
            if indexPath.section == 2 {
                return 350.0
            }
            return 200.0
        }
    }
    
}

extension ProfileViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        self.dismiss(animated: true, completion: { () -> Void in
            //
        })
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        self.profileImage.image = image
        self.profileImage.cornerRadius = self.profileImage.layer.frame.height / 2
        self.profileImage.clipsToBounds = true
    }
}
