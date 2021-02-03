//
//  AddListingDetailViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 27/12/2020.
//

import UIKit
import DropDown
import BEMCheckBox
import Alamofire

class AddListingDetailViewController: BaseViewController, UINavigationControllerDelegate {
    
    //MARK:- Views
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var mainTableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var addMoreDetailButton: UIView!
    @IBOutlet weak var nameTF: CustomAddTextFeild!
    @IBOutlet weak var brandsMenu: CustomDropDownMenu!
    @IBOutlet weak var modelsMenu: CustomDropDownMenu!
    @IBOutlet weak var serialNumberTF: CustomAddTextFeild!
    @IBOutlet weak var modelSeriesTF: CustomAddTextFeild!
    @IBOutlet weak var assetTypeMenu: CustomDropDownMenu!
    @IBOutlet weak var locationTF: CustomAddTextFeild!
    @IBOutlet weak var inYardMenu: CustomDropDownMenu!
    @IBOutlet weak var checkBox: BEMCheckBox!
    @IBOutlet weak var termsAndConditionBtn: UIButton!
    @IBOutlet weak var submitBtn: CustomButton!
    @IBOutlet weak var yearMenu: CustomDropDownMenu!
    @IBOutlet weak var deviceImage: UIImageView!
    @IBOutlet weak var cameraImage: UIImageView!
    @IBOutlet weak var manufacturerTF: CustomAddTextFeild!
    @IBOutlet weak var usageTF: UITextField!
    @IBOutlet weak var usageUnitMenuBtn: UIView!
    @IBOutlet weak var usageUnitLabel: UILabel!
    @IBOutlet weak var arrowBottomIV: UIImageView!
    @IBOutlet weak var priceTF: CustomAddTextFeild!
    
    //init var
    let dropDownMenu = DropDown()
    let contentViewHeight: CGFloat = 2080
    let mainTableHeightConstant: CGFloat = 470
    var numberOfRows = 0
    var detailTitle = "Transmission Details"
    let detailTVcellIdentiifer = "detailTableViewCellIdentifier"
    let transmissionDetailCVIdentifier = "transmissionDetailCollectionViewIdentifier"
    let unitList = ["Hrs", "Mil", "Kms"]
    var brandViewModel : GetBrandListViewModel!
    var brandList = [Brand]()
    var categoryId : String!
    var modelViewModel: GetModelListViewModel!
    var modelList = [Model]()
    var selectedBrandId: Int!
    var assetTypeViewModel : GetAssetTypeViewModel!
    var assetTypes = [AssetType]()
    var sectionViewModel: GetSectionViewModel!
    var sections = [Section]()
    var getYearViewModel : GetYearViewModel!
    var startYear: String!
    var imagePicker = UIImagePickerController()
    var saveImageViewModel: SaveImageViewModel!
    var deviceImageAddress : String?
    var isUsage = false
    var selectedDetails = [String]()
    var addImageCell: DetailTableViewCell?
    var isGetImageForDevice = true
    var images = [[UIImage]]()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewWillLayoutSubviews()
        initViews()
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        if numberOfRows == 0 {
            mainTableHeightConstraint.constant = 0
            contentViewHeightConstraint.constant = contentViewHeight - mainTableHeightConstant
        } else {
            mainTableHeightConstraint?.constant = mainTable.contentSize.height
            contentViewHeightConstraint.constant = mainTable.contentSize.height > mainTableHeightConstant ? mainTableHeightConstraint.constant + contentViewHeight - mainTableHeightConstant : contentViewHeight
        }
    }
    
    //MARK:- Other Methods
    func initViews() {
        self.initScrollView(mainScrollView)
        mainTable.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: detailTVcellIdentiifer)
        mainTable.rowHeight = UITableView.automaticDimension
        addMoreDetailButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnAddMoreDetailButton(_:))))
        brandViewModel = GetBrandListViewModel()
        getBrandsList()
        modelViewModel = GetModelListViewModel()
        modelsMenu.textLabel.text = "- - -"
        assetTypeViewModel = GetAssetTypeViewModel()
        getAssetTypes()
        sectionViewModel = GetSectionViewModel()
        getSection()
        inYardMenu.dropDownMenu.dataSource = ["Yes", "No"]
        inYardMenu.textLabel.text = inYardMenu.dropDownMenu.dataSource[0]
        onSelectYard()
        getYearViewModel = GetYearViewModel()
        getStartYear()
        makeProductImageTouchable()
        saveImageViewModel = SaveImageViewModel()
        arrowBottomIV.image = arrowBottomIV.image?.withRenderingMode(.alwaysTemplate)
        arrowBottomIV.tintColor = .white
        usageUnitMenuBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnUsageUnitMenuButton(_:))))
    }
    
    func makeProductImageTouchable() {
        deviceImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnAddImageForDevice(_:))))
        cameraImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnAddImageForDevice(_:))))
    }
    
    func getImage() {
        let camera = UIAlertAction(title: "camera".getString(), style: .default) { (_) in
            self.getImageFromCamera()
        }
        let library = UIAlertAction(title: "photoLibrary".getString(), style: .default) { (_) in
            self.getImageFromLibrary()
        }
        self.showActionSheet(title: "selectPhoto".getString(), message: "uploadImage".getString(), style: .actionSheet, actions: [camera, library, actionMessageCancel()])
    }
    
    @objc func didTapOnAddImageForDevice(_ sender: UITapGestureRecognizer) {
        isGetImageForDevice = true
        getImage()
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
            imagePicker.cameraDevice = .rear
            imagePicker.showsCameraControls = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func initBrandListMenu() {
        self.brandList.forEach { (value) in
            self.brandsMenu.dropDownMenu.dataSource.append(value.name)
        }
        brandsMenu.textLabel.text = self.brandList[0].name
        onSelectBrandsMenu()
    }
    
    func initModelsListMenu() {
        modelsMenu.dropDownMenu.dataSource.removeAll()
        self.modelList.forEach { (value) in
            self.modelsMenu.dropDownMenu.dataSource.append(value.name)
        }
        modelsMenu.textLabel.text = self.modelList[0].name
        onSelectModelsMenu()
    }
    
    func initAssetTypeMenu() {
        self.assetTypes.forEach { (value) in
            self.assetTypeMenu.dropDownMenu.dataSource.append(value.name)
        }
        assetTypeMenu.textLabel.text = self.assetTypes[0].name
        onSelectAssetType()
    }
    
    func initStartYear() {
        let currentYear = Calendar.current.component(.year, from: Date())
        let startYear = Int(self.startYear!)!
        let difference = currentYear - startYear
        for d in 0...difference {
            self.yearMenu.dropDownMenu.dataSource.append("\(startYear + d)")
        }
        yearMenu.textLabel.text = yearMenu.dropDownMenu.dataSource[0]
        onSelectYearMenu()
    }
    
    //MARK:- Api call
    func getBrandsList() {
        Utility.showHudLoading()
        brandViewModel.getBrandList(category: Int(categoryId)) { (brandList, error) in
            if error == nil {
                Utility.hideHudLoading()
                if let brands = brandList {
                    self.brandList = brands
                    self.initBrandListMenu()
                }
            } else {
                Utility.hideHudLoading()
                self.showActionSheet(title: "error".getString(), message: error!.localizedDescription, style: .alert, actions: [self.actionMessageClose()])
            }
        }
    }
    
    func getModelsList() {
        Utility.showHudLoading()
        modelViewModel.getModel(brandId: selectedBrandId) { (modelList, error) in
            if error == nil {
                Utility.hideHudLoading()
                if let models = modelList, !models.isEmpty {
                    self.modelList = models
                    self.initModelsListMenu()
                }
            } else {
                Utility.hideHudLoading()
                self.showActionSheet(title: "error".getString(), message: error!.localizedDescription, style: .alert, actions: [self.actionMessageClose()])
            }
        }
    }
    
    func getAssetTypes() {
        Utility.showHudLoading()
        assetTypeViewModel.getAssetType { (assetTypes, error) in
            if error == nil {
                Utility.hideHudLoading()
                if let assetList = assetTypes {
                    self.assetTypes = assetList
                    self.initAssetTypeMenu()
                }
            } else {
                Utility.hideHudLoading()
                self.showActionSheet(title: "error".getString(), message: error!.localizedDescription, style: .alert, actions: [self.actionMessageClose()])
            }
        }
    }
    
    func getSection() {
        Utility.showHudLoading()
        sectionViewModel.getSection { (allSection, error) in
            if error == nil {
                Utility.hideHudLoading()
                if let sections = allSection {
                    self.sections = sections                    
                }
            } else {
                Utility.hideHudLoading()
                self.showActionSheet(title: "error".getString(), message: error!.localizedDescription, style: .alert, actions: [self.actionMessageClose()])
            }
        }
    }
    
    func getStartYear() {
        Utility.showHudLoading()
        getYearViewModel.getYear { (year, error) in
            if error == nil {
                Utility.hideHudLoading()
                if let year = year {
                    self.startYear = year
                    self.initStartYear()
                }
            } else {
                Utility.hideHudLoading()
                self.showActionSheet(title: "error".getString(), message: error!.localizedDescription, style: .alert, actions: [self.actionMessageClose()])
            }
        }
    }
    
    func saveImage(imageData: Data, image: UIImage) {
        Utility.showHudLoading()
        saveImageViewModel.saveImage(imageData: imageData) { (address, error) in
            if error == nil {
                Utility.hideSuccessHudLoading()
                if let imageAddress = address?.pic {
                    self.deviceImageAddress = imageAddress
                    self.uploadCompleted(image: image)
                } else {
                    self.showActionSheet(title: "error".getString(), message: "server".getString(), style: .alert, actions: [self.actionMessageClose()])
                }
            } else {
                Utility.hideHudLoading()
                if let error = error {
                    if error.code == 10 {
                        self.showActionSheet(title: "error".getString(), message: "uploadLocal".getString(), style: .alert, actions: [self.actionMessageClose()])
                    }
                    self.showActionSheet(title: "error".getString(), message: error.message, style: .alert, actions: [self.actionMessageClose()])
                }
            }
        }
    }
    
    func uploadCompleted(image: UIImage) {
        self.deviceImage.image = image
        self.cameraImage.isHidden = true
    }
    
    //MARK:- Actions
    @objc func didTapOnAddMoreDetailButton(_ sender: UITapGestureRecognizer) {
        if numberOfRows >= self.sections.count {
            self.showActionSheet(title: "error".getString(), message: "addDetailRow".getString(), style: .alert, actions: [self.actionMessageClose()])
            return
        }
        isUsage = false
        let bottomSheetVC = AppStoryboard.BottomSheet.viewController(viewControllerClass: CustomBottomSheetViewController.self)
        bottomSheetVC.descList = [String]()
        sections.forEach { (value) in
            bottomSheetVC.descList?.append(value.name)
        }
        bottomSheetVC.delegate = self
        bottomSheetVC.titleLabelText = "More Detail"
        present(bottomSheetVC, animated: true, completion: nil)
    }
    
    @IBAction func didTapOnBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapOnUsageUnitMenuButton(_ sender: UITapGestureRecognizer) {
        isUsage = true
        let bottomSheetVC = AppStoryboard.BottomSheet.viewController(viewControllerClass: CustomBottomSheetViewController.self)
        bottomSheetVC.descList = unitList
        bottomSheetVC.delegate = self
        bottomSheetVC.titleLabelText = "Usage Unit"
        present(bottomSheetVC, animated: true, completion: nil)
    }
    
    func onSelectBrandsMenu() {
        brandsMenu.dropDownMenu.selectionAction = { [unowned self] (index: Int, item: String) in
            self.brandsMenu.textLabel.text = item
            self.selectedBrandId = brandList[index].id
            self.getModelsList()
        }
    }
    
    func onSelectModelsMenu() {
        modelsMenu.dropDownMenu.selectionAction = { [unowned self] (index: Int, item: String) in
            self.modelsMenu.textLabel.text = item
        }
    }
    
    func onSelectAssetType() {
        assetTypeMenu.dropDownMenu.selectionAction = { [unowned self] (index: Int, item: String) in
            self.assetTypeMenu.textLabel.text = item
        }
    }
    
    func onSelectYard() {
        inYardMenu.dropDownMenu.selectionAction = { [unowned self] (index: Int, item: String) in
            self.inYardMenu.textLabel.text = item
        }
    }
    
    func onSelectYearMenu() {
        yearMenu.dropDownMenu.selectionAction = { [unowned self] (index: Int, item: String) in
            self.yearMenu.textLabel.text = item
        }
    }
}

//MARK:- TableView delegate and data source
extension AddListingDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: detailTVcellIdentiifer, for: indexPath) as? DetailTableViewCell {
            cell.mainTitleLabel.text = detailTitle
            cell.delegate = self
            if !images.isEmpty {
                cell.imageItems = images[indexPath.row]
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? DetailTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forCell: indexPath.row)
    }
}

//MARK:- CollectionView Delegate and Data Source
extension AddListingDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let items = addImageCell?.imageItems {
            return items.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let item = collectionView.dequeueReusableCell(withReuseIdentifier: transmissionDetailCVIdentifier, for: indexPath) as? AddTransmissionCollectionViewCell {
            item.itemImage.image = addImageCell?.imageItems[indexPath.row]
            return item
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
    
}

extension AddListingDetailViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        self.dismiss(animated: true, completion: { () -> Void in
            //
        })
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            if isGetImageForDevice {
                self.saveImage(imageData: imageData, image: image)
            } else {
                if let cell = addImageCell {
                    if let indexPath = mainTable.indexPath(for: cell) {
                        //images[indexPath.row].append(image)
                        print(indexPath.row)
                        images.append([image])
                    }
                    mainTable.reloadData()
                }
                //let indexPath = mainTable.indexPath(for: addImageCell!)
                
                
            }
        }
    }
}

extension AddListingDetailViewController: GetSelectedDescription {
    func getSelectedText(text: String) {
        var canAdd = true
        if isUsage {
            self.usageUnitLabel.text = text
        } else {
            for detail in selectedDetails {
                if detail.contains(text)  {
                    canAdd = false
                }
            }
            if canAdd {
                selectedDetails.append(text)
                numberOfRows += 1
                detailTitle = text
                let indexPath = IndexPath(row: numberOfRows - 1, section: 0)
                mainTable.insertRows(at: [indexPath], with: .left)
                mainTable.layoutIfNeeded()
                viewWillLayoutSubviews()
            } else {
                showActionSheet(title: "error".getString(), message: "addAnotherDetail".getString(), style: .alert, actions: [self.actionMessageClose()])
            }
        }
    }
}

extension AddListingDetailViewController: DeleteDetailRow {
    func didTapOnDeleteButton(cell: DetailTableViewCell) {
        if let targetIndexPath = mainTable.indexPath(for: cell) {
            numberOfRows -= 1
            mainTable.deleteRows(at: [targetIndexPath], with: .right)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.viewWillLayoutSubviews()
            }
        }
    }
    
    func didTapOnAddButton(cell: DetailTableViewCell) {
        isGetImageForDevice = false
        self.addImageCell = cell
        getImage()
    }
}
