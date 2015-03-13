//
//  WriteViewController.swift
//  MemoApp
//
//  Created by wadadon on 2015/01/31.
//  Copyright (c) 2015年 DAWA. All rights reserved.
//

import UIKit

let UD = NSUserDefaults.standardUserDefaults()   //UserDefaultsインスタンス生成

var tag:[String] = ["hogehoge"]   //配列生成
var memo:[String]=["hoge"]

var key:String = ""


class WriteViewController :UIViewController {
    
     @IBOutlet var writeView : UITextView!
    var aleart = UIAlertView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //NavigationControllerの文字色の変更
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]
        // NavigationControllerのNavigationItemの色
        self.navigationController?.navigationBar.tintColor = UIColor.orangeColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(){
        writeView.resignFirstResponder()   //キーボード閉じる
        writeView.text = ""   //writeViewのテキストをnullに
    }

    @IBAction func save(){
        
        println(memo)
        
        memo.append(writeView.text)   //arrayにwriteViewの内容を追加
        println(memo)
        UD.setObject(memo, forKey: "array")   //メモ内容保存
        println(memo)
        UD.synchronize()   //あったほうが良い?
        
        writeView.text=""
        self.view.endEditing(true)   //キーボードを閉じる
        
        //アラートの表示
        aleart.title = "Save"
        aleart.addButtonWithTitle("OK")
        aleart.show()
        
        
        //dismissViewControllerAnimated(true, completion: nil)   //トップページに戻る

    }
    
    
}


