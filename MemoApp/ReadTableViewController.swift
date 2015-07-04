//
//  ReadTableViewController.swift
//  MemoApp
//
//  Created by wadadon on 2015/05/09.
//  Copyright (c) 2015年 DAWA. All rights reserved.
//

import UIKit

var text : String!
var cellNum : Int!
var url : NSString = "https://www.google.co.jp"
var nowUrl : String!

var tag:[String] = ["hogehoge"]   //配列生成
var memo:[String]=["hoge"]

class ReadTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate {
    
    @IBOutlet var tableview : UITableView!
    @IBOutlet var imageView : UIImageView!
    @IBOutlet var label : UILabel!
    @IBOutlet var searchBar : UISearchBar!
    
    var searchResults = [""]  //検索結果格納用
    var searchString : String = "" //検索する言葉
    
     var scrollBeginingPoint: CGPoint!  //スクロール検知

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSLog("ViewDidLoad")
        
/*---------tableviewの設定---------*/
        tableview.dataSource = self
        tableview.delegate = self
        tableview.backgroundColor = nil;  //背景透過
        tableview.separatorColor = UIColor(red: 165/255, green:190/255 , blue: 0/255, alpha: 1.0)
/*----------------------------------*/
        
/*----------cellの長押し処理用----------*/
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "rowButtonAction:")
        longPressRecognizer.allowableMovement = 15
        longPressRecognizer.minimumPressDuration = 0.6
        self.tableview .addGestureRecognizer(longPressRecognizer)
/*---------------------------------------*/
        
/*---------searchBarの設定---------*/
        self.searchBar = UISearchBar()
        self.searchBar.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: 40)
        self.searchBar.delegate = self
        self.searchBar.showsCancelButton = true
        self.tableview.tableHeaderView = self.searchBar
/*----------------------------------*/
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        NSLog("ViewDidAppear")
        
        let result : AnyObject! = UD.objectForKey("array")
        if(result != nil){
            //UserDefaultsから読み込み
            memo = NSUserDefaults.standardUserDefaults().objectForKey("array") as! [String]
            viewNum = 0
        }
        
        if(memo.count==0){
            label.hidden=false
        }else{
            label.hidden=true
        }
        
        tableview.reloadData()   //tableViewの更新
        var v:UIView = UIView(frame: CGRectZero)
        v.backgroundColor = UIColor.clearColor()
        tableview.tableFooterView = v
        tableview.tableHeaderView = v
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("ViewWillAppear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("DataSource")
        //cellの数を決定
        if(searchString == "") {
            // 通常のTableView
            return memo.count
        } else {
            // 検索結果TableView
            return searchResults.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = memo[indexPath.row]  //cellのテキストを設定
        if(searchString == "") {
            // 通常のTableView
            cell.textLabel?.text = memo[indexPath.row]
        } else {
            // 検索結果TableView
            cell.textLabel?.text = searchResults[indexPath.row]
        }
        cell.textLabel?.textColor = UIColor.blackColor()  //cellのテキストカラーを設定
        cell.backgroundColor = nil;  //cellのバックグラウンドカラーを設定
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        
        //cellがタップされた時の挙動
        cellNum = indexPath.row   //何番目のcellがタップされたか
        
        text = memo[indexPath.row]   //タップされたcellの内容を取得
        println(text)
        
        //画面遷移←アニメーションをpushにしたい
        let hoge =  UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Edit") as! EditViewController
        var hogeNavigationVC = UINavigationController(rootViewController: hoge)
        hogeNavigationVC.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        //親のViewControllerから画面遷移を行わないとエラーが出る
        self.parentViewController?.view.window?.rootViewController?.presentViewController(hogeNavigationVC, animated: true, completion: nil)
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
/*---------検索処理---------*/
    //サーチバー更新時(UISearchBarDelegateを関連づけておく必要がある）
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchBar.text
        searchResults = memo.filter({ (text : String) -> Bool in
            let stringMatch = text.rangeOfString(searchText)
            return (stringMatch != nil)
        })
        var i = 0
        for(i;i<searchResults.count;i++){
          NSLog(self.searchResults[i], String())
        }
        tableview.reloadData()  //データ更新
    }
    
    //キャンセルクリック時
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.view.endEditing(true)
    }

    //リターンキーでキーボード閉じる
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        scrollBeginingPoint = scrollView.contentOffset;
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var currentPoint = scrollView.contentOffset;
        if(scrollBeginingPoint.y < currentPoint.y){
            println("上へスクロール")
            self.tableview.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: false)
        }else{
            println("下へスクロール")
        }
    }
/*---------------------------*/
    
/*-------長押しされた時の処理------*/
    func rowButtonAction(sender : UILongPressGestureRecognizer) {
        
        let point: CGPoint = sender.locationInView(tableview)
        let indexPath = tableview.indexPathForRowAtPoint(point)
        
        if let indexPath = indexPath {
            if sender.state == UIGestureRecognizerState.Began {
                
                // セルが長押しされたときの処理
                println("long pressed \(indexPath.row)")
                
                //アラートコントローラーを作成
                var aleart = UIAlertController()
                
                //キャンセル用ボタン
                let cancelAction:UIAlertAction = UIAlertAction(title: "Cancel",
                    style: UIAlertActionStyle.Cancel,
                    handler:{
                        (action:UIAlertAction!) -> Void in
                })
                
                //削除
                let destructiveAction:UIAlertAction = UIAlertAction(title: "Delete",
                    style: UIAlertActionStyle.Destructive,
                    handler:{
                        (action:UIAlertAction!) -> Void in
                        println("削除や変動的な処理")
                        memo.removeAtIndex(indexPath.row)   //配列の要素を削除
                        self.tableview.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                        
                        UD.setObject(memo, forKey: "array")   //メモ内容保存
                        println(memo)
                        UD.synchronize()   //あったほうが良い?
                        
                        if(memo.count==0){
                            self.label.hidden=false
                        }else{
                       self.label.hidden=true
                        }
                })
                
                //定義したアクションを追加
                aleart.addAction(cancelAction)
                aleart.addAction(destructiveAction)
                
                 presentViewController(aleart, animated: true, completion: nil)
            }
        }else{
            println("long press on table view")
        }
    }
    
/*------------------------------------*/
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
}
