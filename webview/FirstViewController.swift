//
//  FirstViewController.swift
//  webview
//
//  Created by Thomas A. Smedmann on 27/09/2019.
//  Copyright © 2019 Thomas A. Smedmann. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var containerView: UIView!
    
    private var webViewController: WebViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        webViewController = WebContentWebViewController()
        addChild(webViewController)
        // TODO: Sette størrelse på webView?
        webViewController.view.frame = self.containerView.bounds
        containerView.addSubview(webViewController.view)
        // TODO: Sette andre properties på viewController?
        webViewController.didMove(toParent: self)
    }

    @IBAction func openUrl(_ sender: Any) {
        guard let url = URL(string: textField.text ?? "") else {
            return
        }
        
        webViewController.load(url: url)
    }
    
    @IBAction func openWebViewModal(_ sender: Any) {
        guard let url = webViewController.url else {
            return
        }
        
        let request = URLRequest(url: url)
        let storyboard = UIStoryboard(name: "ModalWebView", bundle: Bundle.main)
        guard let modalWebViewController = storyboard.instantiateViewController(withIdentifier: "ModalWebViewController") as? ModalWebViewController else {
            return
        }

        // See HTTPCookieStorage and WKHTTPCookieStore

//        webViewController.getCookies({ cookies in
//            DispatchQueue.main.async(execute: {
////                modalWebViewController.cookies = cookies
//                modalWebViewController.request = request
//                self.present(modalWebViewController, animated: true, completion: nil)
//            })
//        })

//        webViewController.deleteCookies({
//            DispatchQueue.main.async(execute: {
//                modalWebViewController.request = request
//                self.present(modalWebViewController, animated: true, completion: nil)
//            })
//        })

    }
    
}

