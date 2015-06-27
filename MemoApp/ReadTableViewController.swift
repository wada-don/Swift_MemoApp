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

class ReadTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableview : UITableView!
    @IBOutlet var imageView : UIImageView!
    
    var visualEffectView:UIVisualEffectView!
    
    var blur  = 0  //ブラーエフェクトがかかっているか判定

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSLog("ViewDidLoad")
        
        
        tableview.dataSource = self
        tableview.delegate = self
        
        //NavigationControllerの文字色の変更
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]
        // NavigationControllerのNavigationItemの色
        self.navigationController?.navigationBar.tintColor = UIColor.orangeColor()
        
        tableview.backgroundColor = nil;  //TableViewの背景透過
        
        /*-----cellの長押し処理用の云々-----*/
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "rowButtonAction:")
        longPressRecognizer.allowableMovement = 15
        longPressRecognizer.minimumPressDuration = 0.6
        self.tableview .addGestureRecognizer(longPressRecognizer)
        
        tableview.separatorColor = UIColor(red: 237/255, green:28/255 , blue: 158/255, alpha: 1.0)

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
        tableview.reloadData()   //tableViewの更新
        
        if(blur == 0){  //ブラーがかかっていない時の処理
            blur = 1;
            
            // ブラーエフェクトを生成（ここでエフェクトスタイルを指定する）
            let blurEffect = UIBlurEffect(style: .Light)
            
            // ブラーエフェクトからエフェクトビューを生成
           visualEffectView = UIVisualEffectView(effect: blurEffect)
            
            // エフェクトビューのサイズを指定（オリジナル画像と同じサイズにする）
            visualEffectView.frame = imageView.bounds
            
            // 画像にエフェクトビューを貼り付ける
            //imageView.addSubview(visualEffectView)
            
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("ViewWillAppear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        visualEffectView.removeFromSuperview()
        blur = 0
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
        return memo.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = memo[indexPath.row]  //cellのテキストを設定
        cell.textLabel?.textColor = UIColor.whiteColor()  //cellのテキストカラーを設定
        
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
