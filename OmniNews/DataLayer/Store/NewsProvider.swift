//
//  NewsProvider.swift
//  OmniNews
//
//  Created by Marcin on 06/01/2021.
//

import RxSwift

protocol NewsProvider {
    var queryResult: PublishSubject<[ListItemViewModel]> { get }
    var searchQuery: PublishSubject<String> { get }
    var selectedType: BehaviorSubject<SelectedType> { get }
}
