//
//  WebViewController.swift
//  MemoApp
//
//  Created by wadadon on 2015/03/07.
//  Copyright (c) 2015年 DAWA. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController,UIWebViewDelegate{
    
    let webView : UIWebView = UIWebView()
    @IBOutlet var tool : UIToolbar!
    var myIndiator: UIActivityIndicatorView!   //読み込み時に表示するインジケーター
    //var url = "https://www.google.co.jp"
    var aleart = UIAlertView()
    
   /* required init(coder aDecoder: NSCoder) {
        
        var width = UIScreen.mainScreen().bounds.size.width
        var height = UIScreen.mainScreen().bounds.size.height
        var statusH = UIApplication.sharedApplication().statusBarFrame.height
        
        webView = WKWebView(frame: CGRectMake(0 , statusH , width , height - statusH ))
        super.init(coder: aDecoder)
    }*/
    
    override func viewDidLoad() {
        // Delegate設定
        webView.delegate = self
        
        // Webページの大きさを画面に合わせる
        var rect:CGRect = self.view.frame
        webView.frame = rect
        webView.scalesPageToFit = true
        
        // インスタンスをビューに追加する
        self.view.addSubview(webView)
        
        // URLを指定
        let url: NSURL = NSURL(string: "http://www.apple.com/iphone/")!
        let request: NSURLRequest = NSURLRequest(URL: url)
        
        self.view.bringSubviewToFront(self.tool)  //toolBarを前面に移動
        webView.setTranslatesAutoresizingMaskIntoConstraints(false)  // AutoResizingMaskでのレイアウトをオフにする
        
        //↓autoLayout云々(今回は使わない)
        
//        view.addConstraint(NSLayoutConstraint(item: webView, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1.0, constant: 0.0))
//        view.addConstraint(NSLayoutConstraint(item: webView, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1.0, constant: 0.0))
        
        
        //webView.delegate = self
        // Do any additional setup after loading the view.
        
        // ページ読み込み中に表示させるインジケータを生成.
        myIndiator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        myIndiator.center = self.view.center
        myIndiator.hidesWhenStopped = true
        myIndiator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray

        loadAddressURL()   //サイトに接続
        
         webView.addObserver(self, forKeyPath: "loading", options: .New, context: nil)  //プロパティ監視
        
        tool.tintColor=UIColor.orangeColor()   //toolBarの色変更
        
        // スワイプ検知用
        addSwipeRecognizer()
    }
    
//    deinit{
//        webView.removeObserver(self, forKeyPath: "loading", context: nil)  //Observerの後片付け
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadAddressURL(){  //url読み込み作業
        let requestURL = NSURL(string: url)!
        let req = NSURLRequest(URL: requestURL)
        println(requestURL)
        println(req)
        webView.loadRequest(req)
    }
    

    
    // プロパティ変更時
//    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
//        
//        if keyPath == "loading"{
//            if webView.loading == false{
//              
//                if(webView.URL?.absoluteString != nil){  //通常の動作
//                    
//                    url = webView.URL!.absoluteString!  // 読込完了時のURLを取得するのでリダイレクト後のURLもとれる
//                }else{  //webViewのurlがnilになった時(ネットに繋がってない時など)
//
//                    url = "https://www.google.co.jp"  //nilになるといけないので適当にgoogleのurlを入れる
//                    aleart.title = "通信環境を確認してください"  //アラート表示
//                    aleart.addButtonWithTitle("OK")
//                    aleart.show()
//                }
//                if (webView.estimatedProgress < 0.5){
//                    
//                    //開始が読まれない
//                    startAnimation()  //読み込み開始でインジケーター表示
//                }
//                if (webView.estimatedProgress == 1.0){
//                    stopAnimation()  //読み込み終了でインジケーター非表示
//                }
//            }
//        }
//    }
    
    
    //呼ばれない
    func webView(webView: WKWebView, didCommitNavigation navigation: WKNavigation!){
        //読み込み開始時によばれる
         startAnimation()  //読み込み開始でインジケーター表示
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
    
    func webViewDidStartLoad(webView: UIWebView) {
        startAnimation()  //インジケータの表示開始
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        stopAnimation()  //インジケータの表示終了
    }
    
    
    @IBAction func home(){
        url = "https://www.google.co.jp"
        loadAddressURL()   //ホームに戻る
    }
    
    @IBAction func reroad(){
        webView.reload()  //リロード
    }
    
    @IBAction func back(){
        self.webView.goBack()  //戻る
    }
    
    @IBAction func go(){
        self.webView.goForward()  //進む
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
                dismissViewControllerAnimated(true, completion: nil)   //画面遷移
            case UISwipeGestureRecognizerDirection.Right:
                // 右
                println("right")
                //dismissViewControllerAnimated(true, completion: nil)   //画面遷移

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
