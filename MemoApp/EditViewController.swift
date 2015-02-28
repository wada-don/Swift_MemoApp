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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(){
        dismissViewControllerAnimated(true, completion: nil)   //画面遷移
    }
    
    @IBAction func edit(){
        
        //メモ内容の変更を保存
        
        println(array)
        
        array[cellNum] = editView.text  //arrayにwriteViewの内容を追加
        println(array)
        UD.setObject(array, forKey: "array")   //メモ内容保存
        println(array)
        UD.synchronize()   //あったほうが良い?
        
        dismissViewControllerAnimated(true, completion: nil)   //トップページに戻る
        
    }


}
