//
//  PlaybuzzWebView.swift
//  PlaybuzzWebView
//
//  Created by Luda Fux on 8/8/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit
import WebKit

class PlaybuzzWebView: UIView, WKScriptMessageHandler{//, WKNavigationDelegate,  {
    
    var webView: WKWebView!
    weak var delegate: PlaybuzzWebViewProtocol?
    
    override init (frame : CGRect)
    {
        super.init(frame : frame)
        addBehavior()
    }
    
    convenience init ()
    {
        self.init(frame:CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        addBehavior()
    }
    
    func addBehavior ()
    {
        let contentController = WKUserContentController();
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController
        configuration.allowsInlineMediaPlayback = true
        
        webView = WKWebView(frame: CGRectMake(0, 0, self.frame.width, 250), configuration: configuration)
        webView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        webView.scrollView.addObserver(self, forKeyPath: "contentSize", options: .New, context: nil)
        webView.configuration.userContentController.addScriptMessageHandler(self,name: "callbackHandler")
        
        self.addSubview(webView)
    }
    
    func reloadItem(userID: String,
                    itemAlias:String,
                    showRecommendations: Bool,
                    showShareButton: Bool,
                    showFacebookComments: Bool,
                    showItemInfo: Bool,
                    companyDomain: String)
    {
        if webView.loading {
            webView.stopLoading()
        }
        
        let embedTamplate = "<!DOCTYPE html><html><head> <meta content=\"width=device-width\" name=\"viewport\"> <style>.pb_iframe_bottom{display:none;}.pb_top_content_container{padding-bottom: 0 !important;}</style></head><body> <script type=\"text/javascript\">window.PlayBuzzCallback=function(event){var messageDict={\"event_name\":event.eventName,data:event.data};window.webkit.messageHandlers.callbackHandler.postMessage(messageDict)}</script> <script src=\"//cdn.playbuzz.com/widget/feed.js\" type=\"text/javascript\"> </script> <div class=\"pb_feed\" data-native-id=\"%@\" data-game=\"%@\" data-recommend=\"%@\" data-shares=\"%@\" data-comments=\"%@\" data-game-info=\"%@\" data-platform=\"iPhone\" ></div></body></html>"
        
        let embedString: String = String(format: embedTamplate,
                                         userID,
                                         itemAlias,
                                         showRecommendations ? "true":"false",
                                         showShareButton ? "true":"false",
                                         showFacebookComments ? "true":"false",
                                         showItemInfo ? "true":"false")
        webView.loadHTMLString(embedString, baseURL: NSURL(string:companyDomain))
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>)
    {
        if keyPath == "contentSize"
        {
            self.updatePageViewsFrames()
        }
    }
    
    func updatePageViewsFrames()
    {
        webView.sizeToFit()
        let webViewContentHeight:CGFloat = webView.scrollView.contentSize.height
        webView.frame = CGRectMake(0, 0, self.frame.width, webViewContentHeight)
        self.delegate?.resizePlaybuzzContainer(webViewContentHeight)
        
    }
    
    func userContentController(userContentController: WKUserContentController,didReceiveScriptMessage message: WKScriptMessage)
    {
        
    }
}

// MARK: - EmbededWebViewControllerProtocol
protocol PlaybuzzWebViewProtocol: class
{
    func resizePlaybuzzContainer(height: CGFloat)
}

