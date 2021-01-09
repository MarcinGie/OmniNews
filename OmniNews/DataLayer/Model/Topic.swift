//
//  Topic.swift
//  OmniNews
//
//  Created by Marcin on 06/01/2021.
//

import Foundation

struct Topic: Decodable, ListItem {
    let title: String
    let type: String
}
