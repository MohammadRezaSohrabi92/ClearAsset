//
//  ServiceDetailViewController.swift
//  ClearAsset
//
//  Created by Peyk Office on 28/12/2020.
//

import UIKit

class ServiceDetailViewController: UIViewController {
    
    //MARK:- Views
    @IBOutlet weak var commentTable: UITableView!
    @IBOutlet weak var commentTableHeight: NSLayoutConstraint!
    
    
    //init var
    let commentCellIdentifier = "commentCellIdentifier"
    
    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //initViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        commentTable.reloadData()
    }

    
    //MARK:- other methods
    func initViews() {
        commentTable.register(UINib(nibName: "ServiceCommentCell", bundle: nil), forCellReuseIdentifier: commentCellIdentifier)
        commentTable.keyboardDismissMode = .onDrag
        commentTable.estimatedRowHeight = 100
        commentTable.rowHeight = UITableView.automaticDimension
    }
    
    //MARK:- actions
    
}

extension ServiceDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: commentCellIdentifier, for: indexPath) as? ServiceCommentCell {
            cell.message.text = "aljbcsjldbcj jksb kj bnkj bkj bk jnkjns khb khb kjbkaj n kjbk jnkj kjb kj  kjb kjn k akj bnsk kjsn k kjsbn kk jkjs  kjkj kj jknskj sjdskjndjnv jkf kjdf kfj f vfj v sd sd c djsdkjnsljkdn nsjnkjdnlskndl kn n lsn lknsln lskn lksn lkns "
            commentTableHeight.constant = commentTable.contentSize.height
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
