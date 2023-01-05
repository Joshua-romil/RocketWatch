//
//  WebViewController.swift
//  TestGraphQL
//
//  Created by Joshua George on 2022-12-13.
//

import WebKit
import UIKit

class WebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    public var videoLink: String?
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if videoLink == nil {
            print("Could not find videolink")
        }
        else{
            let myURL = URL(string:videoLink!)
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
        }
        
    }

}
