//
//  WriteViewController.swift
//  MemoApp
//
//  Created by wadadon on 2015/01/31.
//  Copyright (c) 2015年 DAWA. All rights reserved.
//

import UIKit




var key:String = ""
var viewNum = 1


class WriteViewController :UIViewController,UITextViewDelegate {
    
    @IBOutlet  weak var writeView : UITextView!
    @IBOutlet weak var bottomLayoutConstraint : NSLayoutConstraint!
    @IBOutlet var imageView : UIImageView!
     @IBOutlet var tool : UIToolbar!
    @IBOutlet var toolButton : UIBarButtonItem!
    @IBOutlet var label : UILabel!
    
    var aleart = UIAlertView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        writeView.backgroundColor = nil  //背景透過
        writeView.textColor = UIColor.blackColor()
        
        //toolbarの設定
        tool.translucent=false
        toolButton.tintColor=UIColor(red: 103/255, green:148/255 , blue: 54/255, alpha: 1.0)
        
        self.writeView.delegate = self  //textViewをデリゲートする
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
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
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        if IJReachability.isConnectedToNetwork() {
            println("正常な電波状況です")
        } else {
            if (viewNum == 2){  //webViewに遷移した場合のみ表示
                let alert = UIAlertView()
                alert.title = "通信エラー"
                alert.message = "通信状況がよくありません。電波環境を確認後、再度お試しください。"
                alert.addButtonWithTitle("OK")
                alert.show()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(){
        
        /*----------------------------------------*/
        var memoNum=memo.count
        var i: Int = 0
        
        println(memo)
        
        let id:AnyObject = convertUnixTimeFromDate(NSDate())
        let newDic = ["id":id,"contents":writeView.text]
        
        println("newDic=\(newDic)¥¥¥")
        println(memo)
        println(memoArray)
        
        let memoDictionary = ["id":id,"contents":writeView.text]
        
        //Array→NSMutableArrayに直接キャストできない？
        var tempArr : Array = memoArray as Array
        println("beforeReverse=\(tempArr)")
        var tempArr2 = tempArr.reverse()
        println("afterReverse=\(tempArr2)")
        var tArray : NSArray = tempArr2 as NSArray
        memoArray = tArray.mutableCopy() as! NSMutableArray

        memoArray.addObject(memoDictionary)
        
        tempArr  = memoArray as Array
        println("beforeReverse=\(tempArr)")
         tempArr2 = tempArr.reverse()
        println("afterReverse=\(tempArr2)")
         tArray  = tempArr2 as NSArray
        memoArray = tArray.mutableCopy() as! NSMutableArray

        
        /*--------------------------------------------------*/
        
        UD.setObject(memoArray, forKey: "array")   //メモ内容保存
        println(memo)
        UD.synchronize()   //あったほうが良い?
        
        writeView.text=""
        self.view.endEditing(true)   //キーボードを閉じる
        writeView.resignFirstResponder()
        
        //アラートの表示
        aleart.title = "Save"
        aleart.addButtonWithTitle("OK")
        aleart.show()
        
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
        
    //id用unixtime取得
    func convertUnixTimeFromDate(date: NSDate) ->Double {
        var unixtime: Double = date.timeIntervalSince1970
        return unixtime
    }
    
/*---------------------------------------------------------------------------------*/

}


