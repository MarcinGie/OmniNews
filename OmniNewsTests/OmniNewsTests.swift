//
//  OmniNewsTests.swift
//  OmniNewsTests
//
//  Created by Marcin on 05/01/2021.
//

import XCTest
@testable import OmniNews

class OmniNewsTests: XCTestCase {
    func testArticleListItemViewModel() {
        let article = Article(title: "Test article title", imageID: "mhsd8o2m0-asdfa", paragraphs: ["First paragraph", "Second paragraph"])
        let viewModel = ListItemViewModel(item: article)
        
        XCTAssert(viewModel.title == "Test article title")
        XCTAssert(viewModel.paragraphs.count == 2)
        XCTAssert(viewModel.type == nil)
        XCTAssert(viewModel.imageURL == "https://gfx-ios.omni.se/images/mhsd8o2m0-asdfa")
    }
    
    func testTopicListItemViewModel() {
        let article = Topic(title: "Test topic title", type: "Story")
        let viewModel = ListItemViewModel(item: article)
        
        XCTAssert(viewModel.title == "Test topic title")
        XCTAssert(viewModel.paragraphs.count == 0)
        XCTAssert(viewModel.type == "Story")
        XCTAssert(viewModel.imageURL == nil)
    }
}
