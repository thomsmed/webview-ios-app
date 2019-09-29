//
// Created by Thomas A. Smedmann on 27/09/2019.
// Copyright (c) 2019 Thomas A. Smedmann. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebViewPlugin: NSObject, WKScriptMessageHandler {

    private let viewController: UIViewController

    init(withViewController viewController: UIViewController) {
        self.viewController = viewController
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let stringToEcho = message.body as? String else {
            return
        }

        let jsToRun = "console.log('Echo: \(stringToEcho)');"

        message.webView?.evaluateJavaScript(jsToRun, completionHandler: { result, error in
            if let error = error {
                print("Error returning result from plugin: \(error)")
            }
        })
    }
}