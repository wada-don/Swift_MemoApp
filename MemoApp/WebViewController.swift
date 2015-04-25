//
//  WebViewController.swift
//  MemoApp
//
//  Created by wadadon on 2015/03/07.
//  Copyright (c) 2015年 DAWA. All rights reserved.
//

import UIKit

class WebViewController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet var webView : UIWebView!
    @IBOutlet var tool : UIToolbar!
    var myIndiator: UIActivityIndicatorView!   //読み込み時に表示するインジケーター
    var url = "https://www.google.co.jp"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        // Do any additional setup after loading the view.
        
        // ページ読み込み中に表示させるインジケータを生成.
        myIndiator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        myIndiator.center = self.view.center
        myIndiator.hidesWhenStopped = true
        myIndiator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        loadAddressURL()   //ブラウザページが開かれたらgoogleに接続
        
        tool.tintColor=UIColor.orangeColor()   //toolBarの色変更
        
        // スワイプ検知用
        addSwipeRecognizer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadAddressURL(){
        let requestURL = NSURL(string: url)!
        let req = NSURLRequest(URL: requestURL)
        println(requestURL)
        println(req)
        webView.loadRequest(req)
        
    }
    
    
    //WebViewのloadが開始された時に呼ばれるメソッド.
    func webViewDidStartLoad(webView: UIWebView) {
        println("load started")
        startAnimation()
    }
    
    //WebViewのloadが終了した時に呼ばれるメソッド.
    func webViewDidFinishLoad(webView: UIWebView) {
        println("load finished")
        stopAnimation()
    }
    
    //インジケータのアニメーション開始.
    func startAnimation() {
        
        // NetworkActivityIndicatorを表示.
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        // UIACtivityIndicatorを表示.
        if !myIndiator.isAnimating() {
            myIndiator.startAnimating()
        }
        
        // viewにインジケータを追加.
        self.view.addSubview(myIndiator)
    }
    
    //インジケータのアニメーション終了.
    
    func stopAnimation() {
        // NetworkActivityIndicatorを非表示.
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        // UIACtivityIndicatorを非表示.
        if myIndiator.isAnimating() {
            myIndiator.stopAnimating()
        }
    }
    
    
    @IBAction func home(){
        loadAddressURL()   //ホームに戻る
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
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
