//
//  InsightTableViewCell.swift
//  InsightDemo
//
//  Created by AhemadAbbas Vagh on 06/04/19.
//  Copyright © 2019 AhemadAbbas Vagh. All rights reserved.
//

import UIKit

class InsightTableViewCell: UITableViewCell {

    @IBOutlet weak var textView: ReadMoreTextView!
    @IBOutlet weak var loadMoreButton: UIButton!
    @IBOutlet weak var heightConstantLoadMore: NSLayoutConstraint!
    
    let readMoreTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.foregroundColor: UIColor.blue,
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)
    ]
    let readLessTextAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor.blue,
        NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 16)
    ]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.attributedReadMoreText = NSAttributedString(string: "... Read more", attributes: readMoreTextAttributes)
        textView.attributedReadLessText = NSAttributedString(string: " Read less", attributes: readLessTextAttributes)
        textView.maximumNumberOfLines = 14
        textView.shouldTrim = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        textView.onSizeChange = { _ in }
        textView.shouldTrim = true
    }
    
    
}
