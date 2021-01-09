//
//  ListViewController.swift
//  OmniNews
//
//  Created by Marcin on 06/01/2021.
//

import EasyPeasy
import RxCocoa
import RxSwift
import SDWebImage

enum SelectedType: Int {
    case article, topic
}

class ListViewController: NiblessViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 110
        tableView.separatorStyle = .none
        return tableView
    }()

    lazy var searchBar: UISearchBar = {
        return UISearchBar()
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Articles", "Topics"])
        control.selectedSegmentIndex = SelectedType.article.rawValue
        return control
    }()
    
    var selectedItemObservable: Observable<ListItemViewModel> {
        return selectedItem.asObservable()
    }
    
    init(store: NewsProvider) {
        self.store = store
        super.init()
    }
    
    private let disposeBag = DisposeBag()
    private let store: NewsProvider
    private var searchResult: Observable<[ListItemViewModel]> {
        return store.queryResult
    }
    private let selectedItem = PublishSubject<ListItemViewModel>()
    
    override func loadView() {
        super.loadView()
        view.addSubview(searchBar)
        searchBar.easy.layout(Top().to(view, .topMargin), Left(), Right())
        
        view.addSubview(segmentedControl)
        segmentedControl.easy.layout(Top().to(searchBar), Left(5), Right(5))
        
        view.addSubview(tableView)
        tableView.easy.layout(Top().to(segmentedControl), Left(), Right(), Bottom())
        
        tableView.register(ListCell.self, forCellReuseIdentifier: "ListCell")
    }

    override func viewDidLoad() {
        title = "Lists"
        view.backgroundColor = .cyan
        
        bindSelectedType()
        bindSearchBarToQuery()
        bindSearchResultToTableView()
        bindTableSelection()
    }
    
    func bindSelectedType() {
        segmentedControl
            .rx.selectedSegmentIndex
            .map { SelectedType(rawValue: $0) }
            .flatMap { Observable.from(optional: $0) }
            .bind(to: store.selectedType)
            .disposed(by: disposeBag)
    }
    
    func bindSearchBarToQuery() {
        searchBar
            .rx.text
            .orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: store.searchQuery)
            .disposed(by: disposeBag)
    }
    
    func bindSearchResultToTableView() {
        searchResult
            .bind(to: tableView.rx.items(cellIdentifier: "ListCell")) { index, model, cell in
                guard let cell = cell as? ListCell else { return }
                
                if let imageURL = model.imageURL {
                    cell.setup(title: model.title, imageURL: imageURL)
                } else {
                    cell.setup(title: model.title)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func bindTableSelection() {
        tableView
            .rx.modelSelected(ListItemViewModel.self)
            .bind(to: selectedItem)
            .disposed(by: disposeBag)
    }
}
