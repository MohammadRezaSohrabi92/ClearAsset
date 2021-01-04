//
//  ProductViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 03/01/2021.
//

import UIKit

class ProductViewController: BaseViewController {

//MARK:- Views
    @IBOutlet weak var productPicCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var seprateProductPicCollectionView: UICollectionView!
    @IBOutlet weak var constraintContentViewHeight: NSLayoutConstraint!        
    @IBOutlet weak var constraintTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var mainTable: UITableView!
    
    //init var
    let productPicCollectionViewIdentifier = "ProductPicCollectionViewIdentifier"
    let sepratePicCollectionViewIdentifier = "SepratePicCollectionViewIdentifier"
    let firstCVtag = 1000
    let secondCVtag = 2000
    let detailTVcellIdentiifer = "detailTableViewCellIdentifier"
    let transmissionDetailCVIdentifier = "transmissionDetailCollectionViewIdentifier"
    var detailCollectionTag = 0    
    let contentViewHeight: CGFloat = 1280
    let mainTableHeightConstant: CGFloat = 470

//MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initViews()
    }
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.constraintTableViewHeight?.constant = self.mainTable.contentSize.height
        constraintContentViewHeight.constant = self.mainTable.contentSize.height > mainTableHeightConstant ? constraintTableViewHeight.constant + contentViewHeight - mainTableHeightConstant : contentViewHeight
    }
    
//MARK:- Other Methods
    func initViews() {
        mainTable.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: detailTVcellIdentiifer)
        mainTable.rowHeight = UITableView.automaticDimension
        productPicCollectionView.register(UINib(nibName: "ProductPicCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: productPicCollectionViewIdentifier)
        seprateProductPicCollectionView.register(UINib(nibName: "SepratePicProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: sepratePicCollectionViewIdentifier)
        pageControl.numberOfPages = 5
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.appOrangeColor
        productPicCollectionView.isPagingEnabled = true        
    }

//MARK:- Actions
    
    @IBAction func didTapOnCloseButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapOnShareButton(_ sender: Any) {
    }
}

//MARK:- TableView Delegate and Data Source
extension ProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: detailTVcellIdentiifer, for: indexPath) as? DetailTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? DetailTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forCell: indexPath.row)
        detailCollectionTag = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK:- CollectionView delegate and Data Source
extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == firstCVtag {
            return 5
        } else if collectionView.tag == secondCVtag {
            return 5
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == firstCVtag {
            if let item = collectionView.dequeueReusableCell(withReuseIdentifier: productPicCollectionViewIdentifier, for: indexPath) as? ProductPicCollectionViewCell {
                return item
            }
        }
        
        if collectionView.tag == secondCVtag {
            if let item = collectionView.dequeueReusableCell(withReuseIdentifier: sepratePicCollectionViewIdentifier, for: indexPath) as? SepratePicProductCollectionViewCell {
                return item
            }
        }
        print(indexPath.row)
        if collectionView.tag == detailCollectionTag {
            if let item = collectionView.dequeueReusableCell(withReuseIdentifier: transmissionDetailCVIdentifier, for: indexPath) as? AddTransmissionCollectionViewCell {
                return item
            }
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == firstCVtag  {
            return CGSize(width: self.view.frame.width, height: 300)
        } else if collectionView.tag == secondCVtag {
            return CGSize(width: 120, height: 90)
        } else if collectionView.tag == detailCollectionTag {
            return CGSize(width: 110, height: 110)
        }
        return CGSize()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if let collectionView = scrollView as? UICollectionView {
            self.detailCollectionTag = collectionView.tag
            print("detailCollectionTag \(detailCollectionTag)")
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView.tag == firstCVtag {
            self.pageControl.currentPage = indexPath.row
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.tag == firstCVtag {
            return 0
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.tag == firstCVtag {
            return 0
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView.tag == firstCVtag {
            return UIEdgeInsets.zero
        }
        return UIEdgeInsets(top: -15, left: 15, bottom: 0, right: 5)
    }
}
