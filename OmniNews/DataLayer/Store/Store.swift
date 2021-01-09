//
//  Store.swift
//  OmniNews
//
//  Created by Marcin on 06/01/2021.
//

import Firebase
import RxSwift

class Store: NewsProvider {
    let queryResult = PublishSubject<[ListItemViewModel]>()
    let searchQuery = PublishSubject<String>()
    let selectedType = BehaviorSubject<SelectedType>(value: .article)
    
    private let disposeBag = DisposeBag()
    private let ref: DatabaseReference
    private let articlesQuery: DatabaseReference
    private let topicsQuery: DatabaseReference
    
    init() {
        ref = Database.database().reference()
        articlesQuery = ref.child("articles")
        topicsQuery = ref.child("topics")
        
        bindSearchQuery()
    }
    
    func bindSearchQuery() {
        Observable.combineLatest(searchQuery, selectedType)
            .subscribe(onNext: { [weak self] query, type in
                guard let strongSelf = self else { return }
                
                let ref = (type == .article) ? strongSelf.articlesQuery : strongSelf.topicsQuery
                let mapping = (type == .article) ? strongSelf.articlesMapping : strongSelf.topicsMapping
                let child = (type == .article) ? "title/value" : "title"
                
                ref
                    .queryOrdered(byChild: child)
                    .queryStarting(atValue: query)
                    .queryEnding(atValue: query+"\u{f8ff}")
                    .observeSingleEvent(of: .value, with: mapping)
            })
            .disposed(by: disposeBag)
    }
    
    func articlesMapping(snapshot: DataSnapshot) {
        guard let objects = snapshot.children.allObjects as? [DataSnapshot] else { return }
        var articleViewModels: [ListItemViewModel] = []
        for object in objects {
            let articleObject = object.value as? [String: AnyObject]
            let title = articleObject?["title"]?["value"] as? String
            let imageID = (articleObject?["main_resource"]?["image_asset"] as? [String: AnyObject])?["id"] as? String
            let paragraphs = (articleObject?["main_text"]?["paragraphs"]) as? [[String: AnyObject]]
            
            guard let titleUnwrapped = title,
                  let imageIDUnwrapped = imageID,
                  let paragraphsUnwrapped = paragraphs
            else { return }
            
            var texts: [String] = []
            for paragraph in paragraphsUnwrapped {
                guard let text = paragraph["text"]?["value"] as? String else { continue }
                texts.append(text)
            }
            let article = Article(title: titleUnwrapped, imageID: imageIDUnwrapped, paragraphs: texts)
            articleViewModels.append(ListItemViewModel(item: article))
        }
        queryResult.onNext(articleViewModels)
    }
    
    func topicsMapping(snapshot: DataSnapshot) {
        guard let objects = snapshot.children.allObjects as? [DataSnapshot] else { return }
        var topics: [ListItemViewModel] = []
        for object in objects {
            let articleObject = object.value as? [String: AnyObject]
            let title = articleObject?["title"] as? String
            let type = articleObject?["type"] as? String

            guard let titleUnwrapped = title, let typeUnwrapped = type else { return }
            
            let topic = Topic(title: titleUnwrapped, type: typeUnwrapped)
            topics.append(ListItemViewModel(item: topic))
        }

        queryResult.onNext(topics)
    }
}
