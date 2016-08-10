//
//  ViewController.swift
//  PlaybuzzWebView
//
//  Created by Luda Fux on 8/8/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PlaybuzzWebViewProtocol, SettingsTableViewControllerProtocol{
    
    @IBOutlet weak var webViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    @IBOutlet weak var playbuzzView: PlaybuzzWebView!
    
    static var showRecommendations = true
    static var showShareButton = true
    static var showFacebookComments = true
    static var showItemInfo = true
    
    let itemAlias = "nicolediver10/here-is-everything-weve-been-eating-and-drinking-since-1991"
    let userID = UIDevice.currentDevice().identifierForVendor!.UUIDString
    let companyDomain = "http://www.playbuzz.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playbuzzView.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.reloadItem()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if let viewController = segue.destinationViewController as? SettingsTableViewController
        {
            viewController.delegate = self
        }
    }
    
    //MARK: PlaybuzzWebView Protocol
    func resizePlaybuzzContainer(height: CGFloat){
        webViewConstraint.constant = height
        containerHeight.constant = playbuzzView.frame.origin.y + height
    }
    
    func reloadItem()
    {
        playbuzzView.reloadItem(userID,
                                itemAlias: itemAlias,
                                showRecommendations: ViewController.showRecommendations,
                                showShareButton: ViewController.showShareButton,
                                showFacebookComments: ViewController.showFacebookComments,
                                showItemInfo: ViewController.showItemInfo,
                                companyDomain: companyDomain)
    }
}

