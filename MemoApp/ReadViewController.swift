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
        return texts.count   //cellの数を決定
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        //
        cell.textLabel?.text = texts[indexPath.row]   //cellのテキストを決定
        return cell
    }
    
    @IBAction func back(){
        dismissViewControllerAnimated(true, completion: nil)
    }

}

   

