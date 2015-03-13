//
//  GroupEditViewController.swift
//  MemoApp
//
//  Created by wadadon on 2015/02/28.
//  Copyright (c) 2015年 DAWA. All rights reserved.
//

import UIKit

class GroupEditViewController: UIViewController {
    
    @IBOutlet var groupView : UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        groupView.text = tagText   //tagセット
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(){
        
        dismissViewControllerAnimated(true, completion: nil)    //遷移
    }
    
    @IBAction func save(){
        
        key=groupView.text   //memo内容の判別用keyをtag名にする
        
        tag.append(groupView.text)   //arrayにwriteViewの内容を追加
        println(tag)
        UD.setObject(tag, forKey: "tag")   //タグを保存
        println(tag)
        UD.synchronize()   //あったほうが良い?
        
        dismissViewControllerAnimated(true, completion: nil)    //戻る
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
