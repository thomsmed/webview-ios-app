//
//  SecondViewController.swift
//  webview
//
//  Created by Thomas A. Smedmann on 27/09/2019.
//  Copyright © 2019 Thomas A. Smedmann. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    private var webViewController: WebViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        webViewController = LocalContentWebViewController()
        addChild(webViewController)
        // TODO: Sette størrelse på webView?
        webViewController.view.frame = self.containerView.bounds
        containerView.addSubview(webViewController.view)
        // TODO: Sette andre properties på viewController?
        webViewController.didMove(toParent: self)

        let echoPlugin = EchoPlugin(withViewController: self)
        webViewController.installPlugin(echoPlugin)
    }


}

