//
//  NewsViewController.swift
//  OmniNews
//
//  Created by Marcin on 06/01/2021.
//

import RxSwift

class NavigationViewController: NiblessNavigationController {

    private let disposeBag = DisposeBag()
    private let container: DependencyContainer
    
    init(container: DependencyContainer) {
        self.container = container
        super.init()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presentList()
    }
    
    private func presentList() {
        let listViewController = container.listViewController()
        pushViewController(listViewController, animated: false)
        bindListSelection(listViewController)
    }
    
    private func bindListSelection(_ listViewController: ListViewController) {
        listViewController.selectedItemObservable
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] item in
                self?.presentDetails(item)
            })
            .disposed(by: disposeBag)
    }
    
    private func presentDetails(_ viewModel: ListItemViewModel) {
        let detailsViewController = container.detailsViewController(for: viewModel)
        pushViewController(detailsViewController, animated: true)
    }
}
