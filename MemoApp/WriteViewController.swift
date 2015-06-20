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
    @IBOutlet var imageView : UIImageView!
    var aleart = UIAlertView()
    var blur = 0  //ブラー判定用
    
   var visualEffectView :UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //NavigationControllerの文字色の変更
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]
        // NavigationControllerのNavigationItemの色
        self.navigationController?.navigationBar.tintColor = UIColor.orangeColor()
        
        writeView.backgroundColor = nil  //背景透過
        writeView.textColor = UIColor.whiteColor()
        
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
            imageView.addSubview(visualEffectView)
            
        //}
    }
   override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        visualEffectView.removeFromSuperview()
        
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

}


