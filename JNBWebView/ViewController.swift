//
//  ViewController.swift
//  JNBWebView
//
//  Created by Michael De Wolfe on 2015-05-07.
//  Copyright (c) 2015 acmethunder. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {

    var webView:WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()

        let webConfig:WKWebViewConfiguration = WKWebViewConfiguration();

        webConfig.userContentController.addScriptMessageHandler(self, name: "getImage");

        let frame:CGRect = self.view.frame;
        let webView = WKWebView(frame: frame, configuration: webConfig);
        webView.navigationDelegate = self;
        self.view.addSubview(webView);
        self.webView = webView;

        let htmlURL = NSBundle.mainBundle().URLForResource("index", withExtension: "html");
        let htmlString = NSString(contentsOfURL: htmlURL!, encoding: NSUTF8StringEncoding, error: nil);
        webView.loadHTMLString(htmlString! as String, baseURL: nil);

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        if ( navigation != nil ) {
            println("");
        }
    }

    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        self.addImage();
    }

    func addImage() {
        let imageURL = NSBundle.mainBundle().URLForResource("image", withExtension: "png");
        let imageData:NSData = NSData(contentsOfURL: imageURL!)!;
        let options = NSDataBase64EncodingOptions(0);
        let base64:String = imageData.base64EncodedStringWithOptions(options);
        let jsString = "addImage('\(base64)')";
        self.webView?.evaluateJavaScript(jsString, completionHandler: { (item, error) -> Void in
            println(error);
        });

    }


}

