//
//  SettingsTableViewController.swift
//  PlaybuzzWebView
//
//  Created by Luda Fux on 8/10/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    weak var delegate: SettingsTableViewControllerProtocol?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let cell = tableView.cellForRow(at: indexPath)
        {
            switch indexPath.row {
            case 0:
                ViewController.showRecommendations = !ViewController.showRecommendations
                self.shouldShowCheckMark(ViewController.showRecommendations, inCell: cell)
            case 1:
                ViewController.showShareButton = !ViewController.showShareButton
                self.shouldShowCheckMark(ViewController.showShareButton, inCell: cell)
            case 2:
                ViewController.showFacebookComments = !ViewController.showFacebookComments
                self.shouldShowCheckMark(ViewController.showFacebookComments, inCell: cell)
            case 3:
                ViewController.showItemInfo = !ViewController.showItemInfo
                self.shouldShowCheckMark(ViewController.showItemInfo, inCell: cell)
            default:
                print("unspecified cell")
            }
            self.delegate?.reloadItem()
        }
    }
    
    func shouldShowCheckMark(_ should: Bool, inCell cell: UITableViewCell)
    {
        if (should)
        {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
    }
}

@objc protocol SettingsTableViewControllerProtocol:class
{
    func reloadItem()
}
