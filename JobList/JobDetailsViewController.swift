//
//  JobDetailsViewController.swift
//  JobList
//
//  Created by TempAc on 3/15/19.
//  Copyright © 2019 TempAc. All rights reserved.
//

import UIKit
import WebKit

class JobDetailsViewController: UIViewController {

    //MARK: properties
    var detailsURL : String?
    
    //MARK: outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    
    //MARK: override functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // add activity indicator
        self.webView.navigationDelegate = self
        self.activityIndicator.hidesWhenStopped = true
        
        // load details URL
        if let detailsURL = self.detailsURL{
            let request = URLRequest(url: URL(string : detailsURL)!)
            webView.load(request)
            self.activityIndicator.startAnimating()

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension JobDetailsViewController : WKNavigationDelegate{
    //MARK: Navigation delegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.activityIndicator.stopAnimating()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.activityIndicator.stopAnimating()
    }
}
