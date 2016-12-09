//
//  DLDemoMenuViewController.swift
//  DLHamburguerMenu
//
//  Created by Nacho on 5/3/15.
//  Copyright (c) 2015 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

class DLDemoMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // outlets
    @IBOutlet weak var tableView: UITableView!
    let segues = ["Menu","Control", "Settings", "About us!"]
    var arrImageName: [String] = ["Btn-management", "Btn-controls", "Btn-settings","Btn-aboutus"]
    let segues1 = ["\n","\n", "\n", "\n"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.rowHeight = UITableViewAutomaticDimension//// Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: UITableViewDelegate&DataSource methods
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        cell.textLabel?.text = segues1[(indexPath as NSIndexPath).row]
        //cell.textLabel?.numberOfLines = 0
        cell.imageView?.image = UIImage(named:self.arrImageName[indexPath.row])
        return cell

    }
   private func tableView(_ heightForRowAttableView: UITableView, heightForRowAt indexPath: NSIndexPath) -> CGFloat
    {
        return 400 //cell height
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nvc = self.mainNavigationController()
        if let hamburguerViewController = self.findHamburguerViewController() {
            hamburguerViewController.hideMenuViewControllerWithCompletion({ () -> Void in
                nvc.visibleViewController?.performSegue(withIdentifier: self.segues[(indexPath as NSIndexPath).row], sender: nil)
                hamburguerViewController.contentViewController = nvc
            })
        }
    }
   
   
   /* func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35.0
    } */
    // MARK: - Navigation
    
    func mainNavigationController() -> DLHamburguerNavigationController {
        return self.storyboard?.instantiateViewController(withIdentifier: "DLDemoNavigationViewController") as! DLHamburguerNavigationController
    }
    
   }
