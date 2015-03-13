//
//  GroupViewController.swift
//  MemoApp
//
//  Created by wadadon on 2015/02/28.
//  Copyright (c) 2015年 DAWA. All rights reserved.
//

import UIKit

var tagCellNum : Int!
var tagText : String!

class GroupViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet var tableview : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        let result : AnyObject! = UD.objectForKey("tag")
        if(result != nil){
            tag = NSUserDefaults.standardUserDefaults().objectForKey("tag") as [String] //UserDefaultsから読み込み
        }
        
        tableview.reloadData()   //tableViewの更新
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
       return 0
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
         return tag.count   //tableの数を決める
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        //cellのテキストを決定
        cell.textLabel?.text = tag[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        
        //cellがタップされた時の挙動
        tagCellNum = indexPath.row   //何番目のcellがタップされたか
        
        tagText = memo[indexPath.row]   //タップされたcellの内容を取得
        println(tagText)
        
        performSegueWithIdentifier("toGroupEditViewController",sender: nil)   //storyboardで設定したsegueを呼び出している?
        
        tableview.deselectRowAtIndexPath(indexPath, animated: true)   //cellの選択を解除
        
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
