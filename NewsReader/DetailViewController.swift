//
//  DetailViewController.swift
//  NewsReader
//
//  Created by yudsuzuk on 2016/06/28.
//  Copyright © 2016年 yudsuzuk. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var link:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = NSURL(string: self.link) {
            let request = NSURLRequest(URL: url)
            self.webView.loadRequest(request)
            
        }
    }
}
