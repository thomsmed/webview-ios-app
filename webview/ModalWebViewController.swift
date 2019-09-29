//
//  ModalyWebViewController.swift
//  webview
//
//  Created by Thomas A. Smedmann on 28/09/2019.
//  Copyright © 2019 Thomas A. Smedmann. All rights reserved.
//

import Foundation
import UIKit

class ModalWebViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var containerView: UIView!
    
    var webViewController: WebViewController!
    
    var request: URLRequest?
    var cookies: [HTTPCookie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        webViewController = WebViewController()
        addChild(webViewController)
        // TODO: Sette størrelse på webView?
        webViewController.view.frame = self.containerView.bounds
        containerView.addSubview(webViewController.view)
        // TODO: Sette andre properties på viewController?
        webViewController.didMove(toParent: self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let request = request else {
            return
        }

        if let cookies = cookies {
            webViewController.setCookies(cookies)
        }
        webViewController.load(request: request)
    }

}
