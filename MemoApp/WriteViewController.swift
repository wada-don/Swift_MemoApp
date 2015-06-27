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
var viewNum = 1


class WriteViewController :UIViewController,UITextViewDelegate {
    
    @IBOutlet var writeView : UITextView!
    @IBOutlet var imageView : UIImageView!
     @IBOutlet var tool : UIToolbar!
    @IBOutlet var toolButton : UIBarButtonItem!
    @IBOutlet var label : UILabel!
    
    var aleart = UIAlertView()
    var blur = 0  //ブラー判定用
    
   var visualEffectView :UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        writeView.backgroundColor = nil  //背景透過
        writeView.textColor = UIColor.whiteColor()
        
        //toolbarの設定
        tool.barStyle=UIBarStyle.BlackTranslucent
        toolButton.tintColor=UIColor(red: 204/255, green:255/255 , blue: 51/255, alpha: 1.0)
        
        self.writeView.delegate = self  //textViewをデリゲートする
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
  //      if(blur == 0){  //ブラーがかかっていない時の処理
     //       blur = 1;
            
            // ブラーエフェクトを生成（ここでエフェクトスタイルを指定する）
            let blurEffect = UIBlurEffect(style: .Light)
            
            // ブラーエフェクトからエフェクトビューを生成
           visualEffectView = UIVisualEffectView(effect: blurEffect)
            
            // エフェクトビューのサイズを指定（オリジナル画像と同じサイズにする）
            visualEffectView.frame = imageView.bounds
            
            // 画像にエフェクトビューを貼り付ける
            //imageView.addSubview(visualEffectView)
            
        //}
    }
   override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        visualEffectView.removeFromSuperview()
        
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

}


