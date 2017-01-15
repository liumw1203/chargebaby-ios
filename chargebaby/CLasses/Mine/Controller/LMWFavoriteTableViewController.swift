//
//  LMWFavoriteTableViewController.swift
//  chargebaby
//
//  Created by 刘明伟 on 2017/1/2.
//  Copyright © 2017年 刘明伟. All rights reserved.
//

import UIKit

class LMWFavoriteTableViewController: UIViewController {
    
    struct TableViewCellIdentifiers {
        static let myFavoriteCell = "LMWFavoriteTableViewCell"
        static let nothingFoundCell = "NothingFoundCell"
        static let loadingCell = "LoadingCell"
    }
    
    @IBOutlet var tableView: UITableView!
    
    // 搜索结果数据
    var myFavorites: [Favorite] = []
    
    var isLoading = false
    
    
    
    
    
    //    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationItem.title = "我的收藏"
        
        //获取收藏
        if (LMWGlobalUserInfo != nil) {
            myFavorites = (LMWGlobalUserInfo?.favoriteList)!
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // 设置tableView的内容缩进，使之整体处于searchBar之下，108包括：状态栏20，搜索框44，navigationBar高度44
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        // 设置tableView的行高，这里设置为默认值
        tableView.rowHeight = 105
        
        // 向tableView注册cell的Nib文件
        var cellNib = UINib(nibName: TableViewCellIdentifiers.myFavoriteCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.myFavoriteCell)
        cellNib = UINib(nibName: TableViewCellIdentifiers.nothingFoundCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.nothingFoundCell)
        cellNib = UINib(nibName: TableViewCellIdentifiers.loadingCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.loadingCell)
        
        
        
        //        self.view.addSubview(searchBar)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 解析JSON产生的Dictionary，字典转为模型数组
    func parse(dictionary: [[String: Any]]) -> [Charge] {
        // 如果能成功取到字典数组
        //        guard let array = dictionary["results"] as? [Any] else {
        //            print("Expected 'results' array")
        //            return []
        //        }
        
        var myFavorites: [Charge] = []
        
        // 将字典数组转为模型数组
        for resultDict in dictionary {
            if let resultDict = resultDict as? [String: Any] {
                //
                let favoriteResult = Charge()
                
                favoriteResult.name = resultDict["name"] as? String
                favoriteResult.area = resultDict["area"] as? String
                favoriteResult.address = resultDict["address"] as? String
                favoriteResult.charge_no = resultDict["charge_no"] as!String
                
                myFavorites.append(favoriteResult)
                
                
            }
        }
        
        return myFavorites
    }

}

// MARK: - UITableViewDataSource
extension LMWFavoriteTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isLoading {
            return 1
        }else if myFavorites.count == 0 {
            return 1
        } else {
            return myFavorites.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isLoading {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.loadingCell, for: indexPath)
            let spinner = cell.viewWithTag(100) as! UIActivityIndicatorView
            spinner.startAnimating()
            return cell
            
        } else if myFavorites.count == 0 {
            return tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.nothingFoundCell, for: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.myFavoriteCell, for: indexPath) as! LMWFavoriteTableViewCell
            let favorite = myFavorites[indexPath.row]
            cell.configure(for: favorite)
            return cell
        }
    }
}
//// MARK: - UITableViewDelegate
extension LMWFavoriteTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消被选择
        tableView.deselectRow(at: indexPath, animated: true)
        // 点击后跳转到详情页面
        print("详情页")
        let charge:Favorite = myFavorites[indexPath.row]
//        print(charge.name)
        //
        gotoChargeStoryboard(gotoCScharge_no: charge.chargeNo!)
        //        performSegue(withIdentifier: "ShowDetail", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if myFavorites.count == 0 || isLoading {
            return nil
        } else {
            return indexPath
        }
    }
    
    func gotoChargeStoryboard(gotoCScharge_no:String) {
        
        let storyBoard = UIStoryboard(name: "LMWChargeDetailViewStoryboard", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "chargeDetailStoryboard") as!LMWChargeDetailViewController
        
//        let data = LMWDataBaseTools.getChargeByNo(chargeNo: gotoCScharge_no)
        
        vc.charge_no = gotoCScharge_no
        
        self.navigationController?.pushViewController(vc, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
}
