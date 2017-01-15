//
//  LMWSearchViewController.swift
//  chargebaby
//
//  Created by 刘明伟 on 2017/1/3.
//  Copyright © 2017年 刘明伟. All rights reserved.
//

import UIKit

class LMWSearchViewController: UIViewController {

    struct TableViewCellIdentifiers {
        static let searchResultCell = "LMWSearchResultCell"
        static let nothingFoundCell = "NothingFoundCell"
        static let loadingCell = "LoadingCell"
    }
    //获取数据库实例
    var db = SQLiteDB.sharedInstance
    // 搜索结果数据
    var searchResults: [Charge] = []
    
    var hasSearched = false
    var isLoading = false
    
    

    
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchBar = UISearchBar(frame: CGRect(x:0.0, y:0.0, width:SCREENW-30, height: 44))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // 设置tableView的内容缩进，使之整体处于searchBar之下，108包括：状态栏20，搜索框44，navigationBar高度44
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        // 设置tableView的行高，这里设置为默认值
        tableView.rowHeight = 105

        // 向tableView注册cell的Nib文件
        var cellNib = UINib(nibName: TableViewCellIdentifiers.searchResultCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.searchResultCell)
        cellNib = UINib(nibName: TableViewCellIdentifiers.nothingFoundCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.nothingFoundCell)
        cellNib = UINib(nibName: TableViewCellIdentifiers.loadingCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.loadingCell)
        
        // 一进入程序键盘立即自动打开
        searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = true
        
        
        
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        
//        self.view.addSubview(searchBar)

        // Do any additional setup after loading the view.
    }

    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
        print("点击cancle按钮")
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
        
        var searchResults: [Charge] = []
        
        // 将字典数组转为模型数组
        for resultDict in dictionary {
            if let resultDict = resultDict as? [String: Any] {
                //
                let searchResult = Charge()
                
                searchResult.name = resultDict["name"] as? String
                searchResult.area = resultDict["area"] as? String
                searchResult.address = resultDict["address"] as? String
                searchResult.detail = resultDict["detail"] as? String
                searchResult.charge_no = resultDict["charge_no"] as!String

                searchResults.append(searchResult)

                
            }
        }
        
        return searchResults
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


// MARK: - UISearchBarDelegate
extension LMWSearchViewController: UISearchBarDelegate {
    
    // MARK: 用户点击搜索
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("开始搜索")

        performSearch()
    }
    
    // MARK: 执行搜索
    func performSearch() {
        if !searchBar.text!.isEmpty { // 当搜索框中不为空时
            let searchText = "%" + searchBar.text! + "%"
            searchBar.resignFirstResponder()
            
            // 取消上一次搜索
            isLoading = true
            tableView.reloadData()
            
            hasSearched = true
            searchResults = [] // 这是先清空上一次搜索结果
            
            //1、根据搜索框数据，搜索结果
            let data = db.query(sql: "SELECT * FROM charge WHERE area like ? or name like ?" , parameters:[searchText, searchText])


            //2、
            // 字典数组转为模型数组
            self.searchResults = self.parse(dictionary: data)
            
            
            DispatchQueue.main.async {
                self.isLoading = false
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: 设置搜索框与顶部状态栏融为一体
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
}
// MARK: - UITableViewDataSource
extension LMWSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isLoading {
            return 1
        } else if hasSearched == false {
            return 0
        } else if searchResults.count == 0 {
            return 1
        } else {
            return searchResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isLoading {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.loadingCell, for: indexPath)
            let spinner = cell.viewWithTag(100) as! UIActivityIndicatorView
            spinner.startAnimating()
            return cell
            
        } else if searchResults.count == 0 {
            return tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.nothingFoundCell, for: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.searchResultCell, for: indexPath) as! LMWSearchResultCell
            let searchResult = searchResults[indexPath.row]
            cell.configure(for: searchResult)
            return cell
        }
    }
}
//// MARK: - UITableViewDelegate
extension LMWSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消被选择
        tableView.deselectRow(at: indexPath, animated: true)
        // 点击后跳转到详情页面
        print("详情页")
        let charge:Charge = searchResults[indexPath.row]
        print(charge.name)
        //
        gotoChargeStoryboard(gotoCScharge_no: charge.charge_no!, charge: charge)
//        performSegue(withIdentifier: "ShowDetail", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if searchResults.count == 0 || isLoading {
            return nil
        } else {
            return indexPath
        }
    }
    
    func gotoChargeStoryboard(gotoCScharge_no:String, charge:Charge) {
        
//        let storyBoard = UIStoryboard(name: "LMWChargeStoryboard", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "chargeStoryboard") as!LMWChargeViewController
//        
//        vc.charge_no = gotoCScharge_no
        
        let storyBoard = UIStoryboard(name: "LMWChargeDetailViewStoryboard", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "chargeDetailStoryboard") as!LMWChargeDetailViewController
        vc.charge_no = gotoCScharge_no
        
        
        self.navigationController?.pushViewController(vc, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
}
