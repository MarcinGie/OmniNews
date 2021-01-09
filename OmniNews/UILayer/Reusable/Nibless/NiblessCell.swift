//
//  NiblessCell.swift
//  OmniNews
//
//  Created by Marcin on 06/01/2021.
//

import UIKit

open class NiblessCell: UITableViewCell {
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    @available(*, unavailable,
    message: "Loading this view from a nib is unsupported in favor of initializer dependency injection."
    )
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view from a nib is unsupported in favor of initializer dependency injection.")
    }
    
    static var reuseIdentifier: String {
        return "\(self)"
    }
}
