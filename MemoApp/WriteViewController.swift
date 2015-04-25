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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //NavigationControllerの文字色の変更
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]
        // NavigationControllerのNavigationItemの色
        self.navigationController?.navigationBar.tintColor = UIColor.orangeColor()
        
        writeView.backgroundColor = nil  //背景透過
        writeView.textColor = UIColor.whiteColor()
        
        // ブラーエフェクトを生成（ここでエフェクトスタイルを指定する）
        let blurEffect = UIBlurEffect(style: .Light)
        
        // ブラーエフェクトからエフェクトビューを生成
        var visualEffectView = UIVisualEffectView(effect: blurEffect)
        
        // エフェクトビューのサイズを指定（オリジナル画像と同じサイズにする）
        visualEffectView.frame = imageView.bounds
        
        // 画像にエフェクトビューを貼り付ける
        imageView.addSubview(visualEffectView)
        
        // スワイプ検知用
        addSwipeRecognizer()
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
    
    
    
    
    /*------------------------*/
    
    /**
    * スワイプ検知用に登録
    */
    func addSwipeRecognizer() {
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        
        var swipeUp = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        
        var swipeDown = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        
        self.view.addGestureRecognizer(swipeLeft)
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeUp)
        self.view.addGestureRecognizer(swipeDown)
    }
    
    /**
    * スワイプ
    */
    func swiped(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Left:
                // 左
                println("left")
            case UISwipeGestureRecognizerDirection.Right:
                // 右
                println("right")
            case UISwipeGestureRecognizerDirection.Up:
                // 上
                println("up")
            case UISwipeGestureRecognizerDirection.Down:
                // 下
                println("down")
            default:
                // その他
                println("other")
                break
            }
            
        }
    }
    
    
    /*------------------------------*/
    
}


