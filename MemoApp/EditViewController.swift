//
//  EditViewController.swift
//  MemoApp
//
//  Created by wadadon on 2015/02/01.
//  Copyright (c) 2015年 DAWA. All rights reserved.
//

import UIKit


class EditViewController: UIViewController , UITextViewDelegate{
    
    @IBOutlet var editView : UITextView!
    @IBOutlet weak var bottomLayoutConstraint : NSLayoutConstraint!
    @IBOutlet var imageView : UIImageView!
    @IBOutlet var label : UILabel!
    
    var aleart = UIAlertView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editView.textColor = UIColor.blackColor()
        editView.text=text   //内容をセット
        editView.backgroundColor = nil  //背景透過
        
        // NavigationControllerのNavigationItemの色
        self.navigationController?.navigationBar.tintColor = UIColor(red: 103/255, green:148/255 , blue: 54/255, alpha: 1.0)
        //NabigationBarの色
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 241/255, green: 255/255, blue: 250/255, alpha: 1.0)
        
        self.editView.delegate = self  //delegate
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        /*---------キーボード監視用---------*/
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardWillChangeFrame:",
            name: UIKeyboardWillChangeFrameNotification,
            object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardWillHide:",
            name: UIKeyboardWillHideNotification,
            object: nil)
        /*-------------------------------------*/
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent  //ステータスバー
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(){
        dismissViewControllerAnimated(true, completion: nil)   //画面遷移
        editView!.resignFirstResponder()   //キーボード閉じる
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
        
        aleart.title = "Save"
        aleart.addButtonWithTitle("OK")
        aleart.show()
        
        dismissViewControllerAnimated(true, completion: nil)   //トップページに戻る
        
    }
    
    //textviewがフォーカスされたら、Labelを非表示
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        label.hidden = true
        return true
    }
    
    //textviewからフォーカスが外れて、TextViewが空だったらLabelを再び表示
    func textViewDidEndEditing(textView: UITextView) {
        if(textView.text.isEmpty){
            label.hidden = false
        }
    }
    
    
/*---------キーボードとtextViewがかぶらないようにする処理---------*/
    func keyboardWillChangeFrame(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            
            let keyBoardValue : NSValue = userInfo[UIKeyboardFrameEndUserInfoKey]! as! NSValue
            var keyBoardFrame : CGRect = keyBoardValue.CGRectValue()
            let duration : NSTimeInterval = userInfo[UIKeyboardAnimationDurationUserInfoKey]! as! NSTimeInterval
            
            self.bottomLayoutConstraint.constant = keyBoardFrame.height
            
            UIView.animateWithDuration(duration, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
            
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            
            let duration : NSTimeInterval = userInfo[UIKeyboardAnimationDurationUserInfoKey]! as! NSTimeInterval
            
            self.bottomLayoutConstraint.constant = 0
            
            UIView.animateWithDuration(duration, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
            
        }
    }
    
    
/*---------------------------------------------------------------------------------*/
    
}
