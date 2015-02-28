//
//  FirstViewController.swift
//  MemoApp
//
//  Created by wadadon on 2015/01/31.
//  Copyright (c) 2015年 DAWA. All rights reserved.
//

import UIKit

var array:[String]=["hoge"]   //配列生成


class FirstViewController :UIViewController {
    
    var image : UIImage! = UIImage(named: "back.jpg")
    @IBOutlet var imageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imageView.image=image
        
        array.removeAll()   //配列初期化

        
        
        /*----背景のぼかし----*/
        
        //ブラーエフェクトを生成（ここでエフェクトスタイルを指定する）
        let blurEffect = UIBlurEffect(style: .Light)
        // ブラーエフェクトからエフェクトビューを生成
        var visualEffectView = UIVisualEffectView(effect: blurEffect)
        // エフェクトビューのサイズを指定（オリジナル画像と同じサイズにする）
        visualEffectView.frame = imageView.bounds
        // 画像にエフェクトビューを貼り付ける
        imageView.addSubview(visualEffectView)
        
        
        let result : AnyObject! = UD.objectForKey("array")
        if(result != nil){
            array = NSUserDefaults.standardUserDefaults().objectForKey("array") as [String] //UserDefaultsから読み込み
        }
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
