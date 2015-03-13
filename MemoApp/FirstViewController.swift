//
//  FirstViewController.swift
//  MemoApp
//
//  Created by wadadon on 2015/03/07.
//  Copyright (c) 2015年 DAWA. All rights reserved.
//

import UIKit

class FirstViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //アイコン色
        let font:UIFont! = UIFont(name:"HelveticaNeue-Bold",size:10)
        let selectedAttributes:NSDictionary! = [NSFontAttributeName : font, NSForegroundColorAttributeName : UIColor.orangeColor()]
        
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, forState: UIControlState.Selected)
        
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
