//
//  ReadViewController.swift
//  MemoApp
//
//  Created by wadadon on 2015/01/31.
//  Copyright (c) 2015年 DAWA. All rights reserved.
//

import UIKit

class ReadViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var tableview : UITableView!
    var texts = ["hello", "world", "hello", "Swift"]


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableview.delegate = self
        tableview.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //cellの数を決定
        return texts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        //cellのテキストを決定
        
        cell.textLabel?.text = texts[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView?, didSelectRowAtIndexPath indexPath:NSIndexPath!) {
        
        //cellがタップされた時の挙動
        var text: String = texts[indexPath.row]
        println(text)
        
        //遷移
//        let editView = EditViewController()
//        editView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
//        self.presentViewController(editView, animated: true, completion: nil)
        
        //storyboardで設定したsegueを呼び出している?
        performSegueWithIdentifier("toEditViewController",sender: nil)
        
        //cellの選択を解除
        tableview.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    @IBAction func back(){
        
        //遷移
        dismissViewControllerAnimated(true, completion: nil)
    }

}

   

