//
//  ListItemViewModel.swift
//  OmniNews
//
//  Created by Marcin on 09/01/2021.
//

import Foundation

struct ListItemViewModel {
    private let item: ListItem
    
    init(item: ListItem) {
        self.item = item
    }
    
    var title: String {
        return item.title
    }
    
    var imageURL: String? {
        guard let imageID = (item as? Article)?.imageID else { return nil }
        return "https://gfx-ios.omni.se/images/\(imageID)"
    }
    
    var paragraphs: [String] {
        return (item as? Article)?.paragraphs ?? []
    }
    
    var type: String? {
        return (item as? Topic)?.type.capitalized
    }
}
