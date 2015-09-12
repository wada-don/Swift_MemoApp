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
    
    @IBOutlet var webView : UIWebView! = UIWebView()
    @IBOutlet var tool : UIToolbar!
    var myIndiator: UIActivityIndicatorView!   //読み込み時に表示するインジケーター
    var aleart = UIAlertView()
    
    var net = 0  //接続状態確認用
    
    override func viewDidLoad() {
        
        // ページ読み込み中に表示させるインジケータを生成.
        myIndiator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        myIndiator.center = self.view.center
        myIndiator.hidesWhenStopped = true
        myIndiator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        tool.translucent=false
        tool.tintColor=UIColor(red: 103/255, green: 148/255, blue: 54/255, alpha: 1.0)  //buttonの色変更
        
        self.webView.delegate = self  //webViewをdelegate
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        reachabilityCheck ()  //ネットワークチェック
        viewNum = 2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadAddressURL(){  //url読み込み作業
        let requestURL = NSURL(string: url as String)!
        let req = NSURLRequest(URL: requestURL)
        println(requestURL)
        println(req)
        webView.loadRequest(req)
    }
    
    //インジケータのアニメーション開始.
    func startAnimation() {
        
        // NetworkActivityIndicatorを表示.
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        // UIACtivityIndicatorを表示.
        if !myIndiator.isAnimating() {
            myIndiator.frame = CGRect(x: UIScreen.mainScreen().bounds.width/2, y: (UIScreen.mainScreen().bounds.height/2)-80, width: 30, height: 30)
            myIndiator.color = UIColor(red: 103/255, green: 148/255, blue: 54/255, alpha: 1.0)
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
        startAnimation()  //インジケータ表示開始
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        stopAnimation()  //インジケータの表示終了
    }
    
    
    @IBAction func home(){
        url = "https://www.google.co.jp"
        loadAddressURL()   //ホームに戻る
    }
    
    @IBAction func reroad(){
        webView.reload()
    }
    
    @IBAction func back(){
        self.webView.goBack()
    }
    
    @IBAction func go(){
        self.webView.goForward()
    }
    
    func reachabilityCheck () {
        if IJReachability.isConnectedToNetwork() {
            println("正常な電波状況です")
            if(net == 0){  //ネットに接続できていなかったら
                 loadAddressURL()   //googleに接続
            }
            net = 1  //接続状態更新
        } else {
            net = 0  //接続状態更新
        }
    }
    
}
