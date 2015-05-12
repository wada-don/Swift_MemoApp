//
//  ReadViewController.swift
//  MemoApp
//
//  Created by wadadon on 2015/01/31.
//  Copyright (c) 2015年 DAWA. All rights reserved.
//

import UIKit


//var text : String!
//var cellNum : Int!
//var url : NSString = "https://www.google.co.jp"
//var nowUrl : String!


class ReadViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {

    
     @IBOutlet var tableview : UITableView!
    //@IBOutlet var eButton : UIBarButtonItem!
    @IBOutlet var imageView : UIImageView!

    
    var e : Int!  //EditをONにするかOFFにするかの変数
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    
        
        url =  "https://www.google.co.jp"
        nowUrl = url
        
        e = 0
        
        tableview.delegate = self
        tableview.dataSource = self

        //NavigationControllerの文字色の変更
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]
        // NavigationControllerのNavigationItemの色
        self.navigationController?.navigationBar.tintColor = UIColor.orangeColor()
        
        tableview.backgroundColor = nil;  //背景透過
        
        // スワイプ検知用
        //addSwipeRecognizer()
        
        //ボタンタイトル設定
       // eButton.title = "Delete"
        //eButton.tintColor = UIColor.orangeColor()
        
        // ブラーエフェクトを生成（ここでエフェクトスタイルを指定する）
        let blurEffect = UIBlurEffect(style: .Light)
        
        // ブラーエフェクトからエフェクトビューを生成
        var visualEffectView = UIVisualEffectView(effect: blurEffect)
        
        // エフェクトビューのサイズを指定（オリジナル画像と同じサイズにする）
        visualEffectView.frame = imageView.bounds
        
        // 画像にエフェクトビューを貼り付ける
        imageView.addSubview(visualEffectView)
    }
    

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        let result : AnyObject! = UD.objectForKey("array")
        if(result != nil){
                memo = NSUserDefaults.standardUserDefaults().objectForKey("array") as [String] //UserDefaultsから読み込み
        }
        
        tableview.reloadData()   //tableViewの更新
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
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
    
    func tableView(tableView: UITableView?, didSelectRowAtIndexPath indexPath:NSIndexPath!) {
        
        //cellがタップされた時の挙動
        cellNum = indexPath.row   //何番目のcellがタップされたか
        
        text = memo[indexPath.row]   //タップされたcellの内容を取得
        println(text)
        
        //Editモードの時は画面遷移しない
        if(e==0){
            
            //storyboardで設定したsegueを呼び出している
            performSegueWithIdentifier("toEditViewController",sender: nil)
        }
        
        tableview.deselectRowAtIndexPath(indexPath, animated: true)   //cellの選択を解除
        
    }
    
    
/*------------------*/
    
    @IBAction func edit(){
        if(e==0){
            e=1
            
            //ボタンタイトル設定
           //eButton.title = "Done"
            //eButton.tintColor = UIColor.orangeColor()
        }
        else if( e==1 ){
            e=0
            //eButton.title = "Delete"
            //eButton.tintColor = UIColor.orangeColor()
        }
    }
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
            // 削除
            let del = UITableViewRowAction(style: .Default, title: "Delete") {
                (action, indexPath) in
            
                memo.removeAtIndex(indexPath.row)   //配列の要素を削除
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
                UD.setObject(memo, forKey: "array")   //メモ内容保存
                println(memo)
                UD.synchronize()   //あったほうが良い?
            }
        
            del.backgroundColor = UIColor.redColor()
        
            return [del]
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        //スワイプでDeleteが出るようにするかしないか
        if(e==0){return false}
        else {return true}
    }

    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    // ※スワイプで処理する場合、ここでは何もしないが関数は必要
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
 /*------------------------*/
    
    /**
    * スワイプ検知用に登録
    */
    func addSwipeRecognizer() {
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        
        var swipeUp = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        
        var swipeDown = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        
        self.view.addGestureRecognizer(swipeLeft)
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeUp)
        self.view.addGestureRecognizer(swipeDown)
    }
    
    /**
    * スワイプのところ
    */
    func swiped(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Left:
                // 左
                println("left")
                //performSegueWithIdentifier("fromReadtoWebSegue", sender: nil) //画面遷移
                 
                                
            case UISwipeGestureRecognizerDirection.Right:
                
                // 右
                println("right")
                
                //画面遷移
                performSegueWithIdentifier("WriteViewSegue", sender: nil)
                
            case UISwipeGestureRecognizerDirection.Up:
                // 上
                println("up")
            case UISwipeGestureRecognizerDirection.Down:
                // 下
                println("down")
            default:
                // その他
                println("other")
                break
            }
            
        }
    }
    
    
/*------------------------------*/
    
    @IBAction func back(){
        
        dismissViewControllerAnimated(true, completion: nil)   //遷移
    }

}

   

