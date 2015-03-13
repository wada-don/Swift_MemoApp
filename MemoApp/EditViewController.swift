//
//  EditViewController.swift
//  MemoApp
//
//  Created by wadadon on 2015/02/01.
//  Copyright (c) 2015年 DAWA. All rights reserved.
//

import UIKit


class EditViewController: UIViewController {
    
    @IBOutlet var editView : UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
       editView.text=text   //内容をセット
        
        //NavigationControllerの文字色の変更
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]
        // NavigationControllerのNavigationItemの色
        self.navigationController?.navigationBar.tintColor = UIColor.orangeColor()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(){
        dismissViewControllerAnimated(true, completion: nil)   //画面遷移
        editView.resignFirstResponder()   //キーボード閉じる
    }
    
    @IBAction func edit(){
        
        //メモ内容の変更を保存
        
        println(memo)
        
        memo[cellNum] = editView.text  //arrayにwriteViewの内容を追加
        println(memo)
        UD.setObject(memo, forKey: "array")   //メモ内容保存
        println(memo)
        UD.synchronize()   //あったほうが良い?
        
        self.view.endEditing(true)   //キーボードを閉じる
        
        dismissViewControllerAnimated(true, completion: nil)   //トップページに戻る
        
    }


}
