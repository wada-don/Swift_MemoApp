//
//  WriteViewController.swift
//  MemoApp
//
//  Created by wadadon on 2015/01/31.
//  Copyright (c) 2015年 DAWA. All rights reserved.
//

import UIKit

let UD = NSUserDefaults.standardUserDefaults()   //UserDefaultsインスタンス生成


class WriteViewController :UIViewController {
    
     @IBOutlet var writeView : UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(){
        dismissViewControllerAnimated(true, completion: nil)   //遷移
    }

    @IBAction func save(){
        
        println(array)
        
        array.append(writeView.text)   //arrayにwriteViewの内容を追加
        println(array)
        UD.setObject(array, forKey: "array")   //メモ内容保存
        println(array)
        UD.synchronize()   //あったほうが良い?
        
        dismissViewControllerAnimated(true, completion: nil)   //トップページに戻る

    }
    
    
}


