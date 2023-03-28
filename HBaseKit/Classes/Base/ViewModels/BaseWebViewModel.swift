//
//  BaseWebViewModel.swift
//  HBaseKit
//
//  Created by 胡永亮 on 2023/3/25.
//

import UIKit
import RxSwift
import RxCocoa
import WebKit

public enum WebViewSuorceType: String {
    case url = "url"
    case html = "html"
}

open class BaseWebViewModel: BaseViewModel {
    public let rxSourceType = BehaviorRelay<String>(value: WebViewSuorceType.url.rawValue)
    public let rxSource = BehaviorRelay<String?>(value: "")
    public let rxEstimatedProgress = BehaviorRelay<Double>(value: 0.0)
    
    public let rxCanGoBack = BehaviorRelay<Bool>(value: false)
    public let rxCanGoForward = BehaviorRelay<Bool>(value: false)
    public let rxIsLoading = BehaviorRelay<Bool>(value: false)
    
    open func webView(_ webView: WKWebView, estimatedProgress: Double) {}
    
    open func webView(_ webView: WKWebView, didFinish navigation: WKNavigation) {}
    
    open func webView(_ webView: WKWebView, evaluateJavaScript:(event: Any?, error: Error?)?) {}
    
    open func webView(_ webView: WKWebView,
                      runJavaScriptAlertPanelWithMessage message: String,
                      initiatedByFrame frame: WKFrameInfo,
                      completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    open func webView(_ webView: WKWebView,
                      runJavaScriptConfirmPanelWithMessage message: String,
                      initiatedByFrame frame: WKFrameInfo,
                      completionHandler: @escaping (Bool) -> Void) {
        completionHandler(false)
    }
    
    open func webView(_ webView: WKWebView,
                      didReceive challenge: URLAuthenticationChallenge,
                      completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, nil)
    }
    
    open func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation, withError error: Error) {}
    
    open func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        decisionHandler(.allow)
    }
    
    open func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Swift.Void) {
        decisionHandler(.allow)
    }
}
