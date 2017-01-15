//
//  LMWCommentViewController.swift
//  chargebaby
//
//  Created by 刘明伟 on 2017/1/5.
//  Copyright © 2017年 刘明伟. All rights reserved.
//

import UIKit

class LMWCommentViewController: UIViewController,UITextFieldDelegate {
    
    struct TableViewCellIdentifiers {
        static let commentCell = "commentCell"
        static let nothingFoundCell = "NothingFoundCell"
        static let loadingCell = "LoadingCell"
    }

    @IBOutlet weak var textFeild: UITextField!
    @IBOutlet weak var commentToolbar: UIToolbar!
    @IBOutlet weak var commentTableView: UITableView!
    
    
    var commentsResults:CommentResults!
    var chargeNo:String!
    var isLoading = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("点击点评--")
        // 向tableView注册cell的Nib文件
        var cellNib = UINib(nibName: TableViewCellIdentifiers.commentCell, bundle: nil)
        commentTableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.commentCell)
        cellNib = UINib(nibName: TableViewCellIdentifiers.nothingFoundCell, bundle: nil)
        commentTableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.nothingFoundCell)
        cellNib = UINib(nibName: TableViewCellIdentifiers.loadingCell, bundle: nil)
        commentTableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.loadingCell)
        
        commentTableView.register(UINib(nibName: "commentCell", bundle: nil), forCellReuseIdentifier: "commentCell")
        
        // 设置tableView的内容缩进，使之整体处于searchBar之下，108包括：状态栏20，搜索框44，navigationBar高度44
        commentTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        commentTableView.dataSource = self
        commentTableView.delegate = self
        commentsResults = GetDataFromRemote.getComments(chargeNo: chargeNo)
        self.commentTableView.reloadData()
        
        
        textFeild.returnKeyType = .send //标有Send的蓝色按钮
        textFeild.clearButtonMode = .whileEditing  //编辑时出现清除按钮
        textFeild.clearsOnBeginEditing = true
        textFeild.placeholder = "说点什么..."
        
        textFeild.delegate = self
        //对键键的监控，当这些值发生改变时发送通知
        NotificationCenter.default.addObserver(self, selector:#selector(LMWCommentViewController.keyBoardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(LMWCommentViewController.keyBoardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //发送一个名字为currentPageChanged，附带object的值代表当前页面的索引
        NotificationCenter.default.post(name: Notification.Name(rawValue: "currentPageChanged"), object: 1)
    }

    func keyBoardWillShow(_ note:Notification)
    {
        
        
        let userInfo  = note.userInfo as! NSDictionary
        let  keyBoardBounds = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        _ = self.view.convert(keyBoardBounds, to:nil)
        
        _ = commentToolbar.frame
        let deltaY = keyBoardBounds.size.height
        
        let animations:(() -> Void) = {
            
            self.commentToolbar.transform = CGAffineTransform(translationX: 0,y: -deltaY)
        }
        
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            
            UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)
            
            
        }else{
            
            animations()
        }
        
        
    }
    
    func keyBoardWillHide(_ note:Notification)
    {
        
        let userInfo  = note.userInfo as! NSDictionary
        
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        
        let animations:(() -> Void) = {
            
            self.commentToolbar
                .transform = CGAffineTransform.identity
            
        }
        
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            
            UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)
            
            
        }else{
            
            animations()
        }
        
        
        
        
    }
    
    func handleTouches(_ sender:UITapGestureRecognizer){
        
        if sender.location(in: self.view).y < self.view.bounds.height - 250{
            textFeild.resignFirstResponder()
            
            
        }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //判断网络
        LMWTools.checkConnectNet(controller: self)
        
        //判断是否登录
        if (!LMWGlobalIsLogin) {
            LMWTools.showLoginAlert()
            return false
        }
        //收起键盘
        textFeild.resignFirstResponder()
        let info = textFeild.text!
        //打印出文本框中的值
        commentsResults = GetDataFromRemote.addCommet(authorId: (LMWGlobalUserInfo?.id)!, chargeNo: chargeNo, info: info)
        textFeild.text = ""
        self.commentTableView.reloadData()
        
        print(textFeild.text)
        return true;
    }
}



//MARK: - UITableViewDataSource
extension LMWCommentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let result = commentsResults {
            return result.comments.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let comment = commentsResults!.comments[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! commentCell
        cell.layoutSubviews()
        cell.authouLabel.text = comment.author
        cell.infoLabel.text = comment.info
        cell.createTimeLabel.text = comment.createTime
        return cell
    }
}

//MARK: - UITableViewDelegate
extension LMWCommentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
