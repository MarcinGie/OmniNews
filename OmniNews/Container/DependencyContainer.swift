//
//  DependencyContainer.swift
//  OmniNews
//
//  Created by Marcin on 09/01/2021.
//

import Foundation

protocol DependencyContainer {
    func provideStore() -> NewsProvider
    func listViewController() -> ListViewController
    func detailsViewController(for: ListItemViewModel) -> DetailsViewController
}

class DependencyContainerImplementation: DependencyContainer {
    func provideStore() -> NewsProvider {
        return Store()
    }
    
    func listViewController() -> ListViewController {
        return ListViewController(store: provideStore())
    }
    
    func detailsViewController(for item: ListItemViewModel) -> DetailsViewController {
        return DetailsViewController(item: item)
        
    }
}
