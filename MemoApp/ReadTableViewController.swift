//
//  ReadTableViewController.swift
//  MemoApp
//
//  Created by wadadon on 2015/05/09.
//  Copyright (c) 2015年 DAWA. All rights reserved.
//

import UIKit

let UD = NSUserDefaults.standardUserDefaults()   //UserDefaultsインスタンス生成



var text : String!
var cellNum : Int!
var url : NSString = "https://www.google.co.jp"
var nowUrl : String!

var memo :Dictionary<NSObject, AnyObject>=[0: ""]  //dictionary
var memoArray :NSMutableArray! = []
var arr : NSArray!

class ReadTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate {
    @IBOutlet var tableview2 : UITableView!
    
    @IBOutlet var tableview : UITableView!
    @IBOutlet var imageView : UIImageView!
    @IBOutlet var label : UILabel!
     var searchBar : UISearchBar!
    @IBOutlet var scroll : UIScrollView!
    
//    var searchResults:Dictionary<NSObject, AnyObject> = [0: ""]  //検索結果格納用
    var tmpDictionaryArray :[AnyObject] = []
    var searchString : String = "" //検索する言葉
    
    var scrollBeginingPoint: CGPoint!  //スクロール検知
    
    var i  = 0
    var j = 0

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
        //self.tableview.tableHeaderView = self.searchBar
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        var i : Int
        
        NSLog("ViewDidAppear")
        
        let result : AnyObject! = UD.objectForKey("array")
        if(result != nil){
            //UserDefaultsから読み込み
            if UD.objectForKey("array") != nil {
                arr = UD.objectForKey("array")! as! NSMutableArray
                memoArray = NSMutableArray(array: arr)
                
//                for(i=0;i<memoArray.count;i++){
//                    memo[i]=memoArray[i]
//                }
                println(memoArray)
                
                for(i=0;i<memoArray.count;i++){
                    let dic = memoArray[i] as! NSDictionary
                    //println("array[i] = \(dic)")
                    let con:String = dic["contents"] as! String//(memoArray[i] as! String)
                    let id:AnyObject = convertUnixTimeFromDate(NSDate())
                    println("con = \(con)")
                    println("id = \(id)")
                    let memoDictionary = ["id":id,"contents":con]
                    memo[i]=memoDictionary
                    println("memo[i]=\(memo[i])")
                }
                println(i)
                println(memo)
                //println(memoArray)
                
            }
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
        var i:Int
        
        /*
        for(i=0;i<memo.count;i++){
            let con:String = (memo[i] as? String)!
            let memoDictionary = ["id":i,"contents":con]
            memoArray[i]=memoDictionary
        }
        */
        
        for(i=0;i<memo.count;i++){
//            let dic = memoArray[i] as! NSDictionary
//            println("array[i] = \(dic)")
//            let con:String = dic["contents"] as! String//(memoArray[i] as! String)
//            println("con = \(con)")
//            let memoDictionary = ["id":i,"contents":con]
//            memoArray[i]=memoDictionary
        }
        println(memo)
        println(memoArray)
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
//        if(memo.count != 0){
//            if(!searchBar.isFirstResponder()){
//               searchBar.becomeFirstResponder()
//            }
//        }
        
        if(searchString == "") {
            // 通常のTableView
            return memoArray.count
        } else {
            // 検索結果TableView
//            return searchResults.count
            return tmpDictionaryArray.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
       // cell.textLabel?.text = memo[indexPath.row] as? String  //cellのテキストを設定
        if(searchString == "") {
            // 通常のTableView
            let txtDic = memoArray[indexPath.row] as! NSDictionary
            let txt = txtDic["contents"] as! String
            cell.textLabel?.text = txt
        } else {
            // 検索結果TableView
            let txtDic = tmpDictionaryArray[indexPath.row] as! NSDictionary//searchResults[indexPath.row] as! NSDictionary
            let txt = txtDic["contents"] as! String
            cell.textLabel?.text = txt
        }
        cell.textLabel?.textColor = UIColor.blackColor()  //cellのテキストカラーを設定
        cell.backgroundColor = nil;  //cellのバックグラウンドカラーを設定
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        
        //cellがタップされた時の挙動
        cellNum = indexPath.row   //何番目のcellがタップされたか
        
        if(searchString==""){
            text=memo[indexPath.row] as? String
        }else{
//            text=searchResults[indexPath.row] as? String
            let dic = tmpDictionaryArray[indexPath.row] as! NSDictionary
            text = dic["contents"] as! String
        }
        
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
        var i : Int
        
        searchString = searchBar.text
        tmpDictionaryArray=[]
       
        //検索処理
        println("search memo = \(memo)")
        for(i=0;i<memo.count;i++){
            let dic = memo[i] as! NSDictionary
            let content = dic["contents"] as! String
            println("dic = \(dic),content = \(content) ,searchString = \(searchString)")
            if(( content.rangeOfString(searchString)) != nil){
                tmpDictionaryArray.append(memo[i]!)
                
            }
        }
        
        println("tmpDictionary = \(tmpDictionaryArray)")
        
//        for(i=0;i<searchResults.count;i++){
//          NSLog((self.searchResults[i] as? String)!, String())
//        }
        tableview.reloadData()  //データ更新
        
        if(memo.count != 0){
            if(!searchBar.isFirstResponder()){
                searchBar.becomeFirstResponder()
            }
        }
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
        if(scrollBeginingPoint.y <= currentPoint.y){
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
                        
                       
//                            for(var i=0;i<memo.count;i++){
//                                if(memo[i] != nil){
//                                    memoArray[self.j]=(memo[i] as? String)!
//                                    self.j++
//                                }
//                            }
                            memo[indexPath.row]=nil   //配列の要素を削除
                            memoArray.removeObjectAtIndex(indexPath.row)
                            self.tableview.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                        
                        
                                            
//                        for(self.i=0;self.i<memo.count;self.i++){
//                            memo[self.i]=memo[self.i]
//                        }
                        
                        println(memo)
                        UD.setObject(memoArray, forKey: "array")   //メモ内容保存
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
                
                 self.view.window?.rootViewController!.presentViewController(aleart, animated: true, completion: nil)
            }
        }else{
            println("long press on table view")
        }
    }
    
/*------------------------------------*/
    

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
                return  self.searchBar
    }


    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
   
   //id用unixtime取得
    func convertUnixTimeFromDate(date: NSDate) ->Double {
        var unixtime: Double = date.timeIntervalSince1970
        return unixtime
    }


}
