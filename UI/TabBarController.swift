//
//  TabBarController.swift
//  DM
//
//  Created by kien on 11/22/16.
//  Copyright © 2016 kien. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    // MARK: - Button actions
    
    @IBAction func setTopMenu(_ sender: AnyObject) {
        self.findHamburguerViewController()?.menuDirection = .top
    }
    
    @IBAction func setBottomMenu(_ sender: AnyObject) {
        self.findHamburguerViewController()?.menuDirection = .bottom
    }
    
    @IBAction func setLeftMenu(_ sender: AnyObject) {
        self.findHamburguerViewController()?.menuDirection = .left
    }
    
    @IBAction func setRightMenu(_ sender: AnyObject) {
        self.findHamburguerViewController()?.menuDirection = .right
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
