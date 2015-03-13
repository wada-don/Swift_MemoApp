//
//  ReadViewController.swift
//  MemoApp
//
//  Created by wadadon on 2015/01/31.
//  Copyright (c) 2015年 DAWA. All rights reserved.
//

import UIKit

var text : String!
var cellNum : Int!

class ReadViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableview : UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableview.delegate = self
        tableview.dataSource = self

        //NavigationControllerの文字色の変更
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]
        // NavigationControllerのNavigationItemの色
        self.navigationController?.navigationBar.tintColor = UIColor.orangeColor()

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
       
        //cellのテキストを決定
        cell.textLabel?.text = memo[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView?, didSelectRowAtIndexPath indexPath:NSIndexPath!) {
        
        //cellがタップされた時の挙動
        cellNum = indexPath.row   //何番目のcellがタップされたか
        
        text = memo[indexPath.row]   //タップされたcellの内容を取得
        println(text)
        
        performSegueWithIdentifier("toEditViewController",sender: nil)   //storyboardで設定したsegueを呼び出している?
        
        tableview.deselectRowAtIndexPath(indexPath, animated: true)   //cellの選択を解除
        
    }
    
    
/*------------------*/
    
    
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
        return true
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    // ※スワイプで処理する場合、ここでは何もしないが関数は必要
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    
 /*------------------------*/
    
    
    @IBAction func back(){
        
        dismissViewControllerAnimated(true, completion: nil)   //遷移
    }

}

   

