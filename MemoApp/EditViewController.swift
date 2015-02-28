//
//  EditViewController.swift
//  MemoApp
//
//  Created by wadadon on 2015/02/01.
//  Copyright (c) 2015年 DAWA. All rights reserved.
//

import UIKit


class EditViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    }


}
