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
        var i: Int
        
        //メモ内容の変更を保存
        
        println(memo)
        

        

        //検索時に分岐する
        
        if(searchString == ""){
            var dic  = memo[cellNum] as! Dictionary<NSObject, AnyObject>
        
            println("dic=\(dic)")
            dic["contents"] = editView.text as String
        
            memo[cellNum]=dic
            memoArray[cellNum]=memo[cellNum]!
        }else{
            var TD : Dictionary<NSObject,AnyObject> = [:]
            var TDArray : NSMutableArray = []
            let edtTxt = editView.text as String
            var dic = tmpDictionaryArray[cellNum] as! Dictionary<NSObject,AnyObject>
            dic["contents"] = edtTxt
            
            tmpDictionaryArray[cellNum]=dic
            
            let tmpId: Double = dic["id"] as! Double
            
            println("memo=\(memo)")
            
            
            for(var k=0;k<memo.count;k++){
                let Tmp = memo[k] as! NSDictionary
                println("Tmp=\(Tmp)")
                let double : Double = Tmp["id"] as! Double
                println("tmpId=\(tmpId)")
                println("double=\(double)")
                if(double == tmpId){
                    
                    var dic = memo[cellNum] as! Dictionary<NSObject,AnyObject>
                    dic["contents"] = edtTxt
                    memo[k] = dic
                    memoArray[k]=memo[k]!
                    //memo[i]=Tmp
                   // println("i=\(i)")
                    println("Tmp=\(Tmp)")
                    println("memo=\(memo)")
                }
            }
            println("tmopDA=\(tmpDictionaryArray)")
                        
        }

        
        
        println(memo)
        UD.setObject(memoArray as NSArray, forKey: "array")   //メモ内容保存
        println(memo)
        UD.synchronize()   //あったほうが良い?
        
        self.view.endEditing(true)   //キーボードを閉じる
        
        aleart.title = "Save"
        aleart.addButtonWithTitle("OK")
        aleart.show()
        
       self.dismissViewControllerAnimated(true, completion: nil)   //トップページに戻る
       
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
