//
//  RepositoryListViewController.swift
//  RxSwift Github MVVM
//
//  Created by Muhammad Ridho on 5/2/17.
//  Copyright © 2017 Ridho Pratama. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class RepositoryListViewController: UIViewController {

    let userSearchBar           = UISearchBar()
    let repoTableView           = UITableView()
    let repositoryListViewModel = RepositoryListViewModel()
    
    var username: Observable<String> {
        return userSearchBar.rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRx()
    }
    
    func setupRx() {
        repositoryListViewModel.getReposName(username: self.username)
            .observeOn(MainScheduler.instance)
            .catchError({ error in
                self.showAlert(withMessage: "Error occured, maybe internet problem??")
                return Observable.just([])
            })
            .bind(to: repoTableView.rx.items) { (tableView, row, element) in
                let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "repoCell")
                
                let (repoName, detail)      = element
                cell.textLabel?.text        = repoName
                cell.detailTextLabel?.text  = detail
                
                return cell
            }
            .addDisposableTo(disposeBag)
        
        repoTableView.rx
            .modelSelected((String, String).self)
            .subscribe(onNext: { _ in
                if let selectedIndexPath = self.repoTableView.indexPathForSelectedRow {
                    self.repoTableView.deselectRow(at: selectedIndexPath, animated: true)
                }
            })
            .addDisposableTo(disposeBag)
    }
    
    func setupView() {
        self.navigationItem.title                   = "Github Repository List"
        self.view.backgroundColor                   = UIColor.white
        self.automaticallyAdjustsScrollViewInsets   = false
        
        self.userSearchBar.placeholder      = "Search repo by username"
        self.userSearchBar.searchBarStyle   = .prominent
        self.userSearchBar.contentMode      = .scaleToFill
        
        self.repoTableView.backgroundColor  = UIColor.white
        self.repoTableView.register(UITableViewCell.self, forCellReuseIdentifier: "repoCell")
        
        self.view.addSubview(repoTableView)
        self.view.addSubview(userSearchBar)
        
        self.userSearchBar.snp.makeConstraints { make in
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        self.repoTableView.snp.makeConstraints { make in
            make.top.equalTo(self.userSearchBar.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func showAlert(withMessage msg: String) {
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
