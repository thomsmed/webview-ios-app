//
//  WebViewController.swift
//  webview
//
//  Created by Thomas A. Smedmann on 27/09/2019.
//  Copyright © 2019 Thomas A. Smedmann. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebViewController : UIViewController, WKUIDelegate, WKNavigationDelegate {

    private var userContentController: WKUserContentController!
    private var plugins: [WebViewPlugin] = []
    
    var url: URL? {
        get {
            if let wkWebView = view as? WKWebView {
                return wkWebView.url
            }
            return nil
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = buildWebView()
    }

    private func buildWebView() -> WKWebView {
        let frame = CGRect()
        let configuration = self.buildConfiguration()
        let webView = WKWebView(frame: frame, configuration: configuration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        userContentController = webView.configuration.userContentController

        // Inject script:
        // forMainFrameOnly = false : inject script in all WKWebViews associated with this WKUserContentController
        userContentController.addUserScript(WKUserScript(source: "window.injectedScript = true;", injectionTime: .atDocumentEnd, forMainFrameOnly: false))

        return webView
    }

    private func buildConfiguration() -> WKWebViewConfiguration {
        let configuration = WKWebViewConfiguration()
        configuration.applicationNameForUserAgent = "The Ultimate WebView App"
        return configuration
    }

    // MARK: Cookies
    func getCookies(_ completionHandler: @escaping ([HTTPCookie]) -> Void) {
        let configuration = (self.view as! WKWebView).configuration
        let dataStore = configuration.websiteDataStore
        let cookieStore = dataStore.httpCookieStore
        cookieStore.getAllCookies(completionHandler)
    }

    func setCookies(_ cookies: [HTTPCookie]) {
        let configuration = (self.view as! WKWebView).configuration
        let dataStore = configuration.websiteDataStore
        let cookieStore = dataStore.httpCookieStore
        for cookie in cookies {
            cookieStore.setCookie(cookie)
        }
    }

    func deleteCookies(_ completionHandler: @escaping () -> Void) {
        let configuration = (self.view as! WKWebView).configuration
        let dataStore = configuration.websiteDataStore
        let cookieStore = dataStore.httpCookieStore
        cookieStore.getAllCookies({ cookies in
            var n = cookies.count
            for cookie in cookies {
                cookieStore.delete(cookie, completionHandler: {
                    n -= 1
                    if n <= 0 {
                        return completionHandler()
                    }
                })
            }
        })
    }

    // MARK: Plugins
    func installPlugin(_ plugin: WebViewPlugin) {
        // window.webkit.messageHandlers.name.postMessage(messageBody)
        let typeOfPlugin = type(of: plugin)
        let name = String(describing: typeOfPlugin)
        userContentController.add(plugin, name: name)
    }

    // MARK: Loading Content
    func load(url: URL) {
        let request = URLRequest(url: url)
        (self.view as! WKWebView).load(request)
    }
    
    func load(request: URLRequest) {
        (self.view as! WKWebView).load(request)
    }

    func loadFileUrl(_ url: URL, allowingReadAccessTo readAccessUrl: URL) {
        (self.view as! WKWebView).loadFileURL(url, allowingReadAccessTo: readAccessUrl)
    }

    func loadHTMLString(_ string: String, baseUrl: URL?) {
        (self.view as! WKWebView).loadHTMLString(string, baseURL: baseUrl)
    }

    // MARK: Navigation
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("starts to receive web content")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finished receiving web content")
    }

    // MARK: UI


    // MARK: Script

}
