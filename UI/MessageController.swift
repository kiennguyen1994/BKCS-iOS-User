//
//  MessageController.swift
//  UI
//
//  Created by kien on 11/30/16.
//  Copyright © 2016 kien. All rights reserved.
//

import UIKit

class MessageController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let titleButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 32))
        titleButton.setTitle("Message", for: .normal)
        titleButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20.0)
        titleButton.setTitleColor(UIColor.white, for: .normal)
        //titleButton.addTarget(self, action: Selector("titlepressed:"), for: UIControlEvents.touchUpInside)
        self.navigationItem.titleView = titleButton
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func MenuButton(_ sender: Any) {
        self.findHamburguerViewController()?.showMenuViewController()
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
