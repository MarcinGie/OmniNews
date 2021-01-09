//
//  DetailsViewController.swift
//  OmniNews
//
//  Created by Marcin on 09/01/2021.
//

import EasyPeasy

class DetailsViewController: NiblessViewController {
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    init(item: ListItemViewModel) {
        super.init()
        configure(with: item)
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.easy.layout(Top(5).to(view, .topMargin), Left(5), Right(5), Bottom())
        scrollView.addSubview(stackView)
        
        stackView.easy.layout(Edges(), Width().like(scrollView))
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
    }
    
    private func configure(with viewModel: ListItemViewModel) {
        add(title: viewModel.title)
        add(paragraphs: viewModel.paragraphs)
        add(type: viewModel.type)
    }
    
    private func add(title: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.backgroundColor = .systemGray5
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textAlignment = .center
        
        stackView.addArrangedSubview(titleLabel)
    }
    
    private func add(paragraphs: [String]) {
        for text in paragraphs {
            let paragraph = UILabel()
            paragraph.numberOfLines = 0
            
            let style = NSMutableParagraphStyle()
            style.firstLineHeadIndent = 50
            paragraph.attributedText = NSAttributedString(string: text, attributes: [.paragraphStyle : style])
            
            stackView.addArrangedSubview(paragraph)
        }
    }
    
    private func add(type: String?) {
        guard let type = type else { return }
        
        let typeLabel = UILabel()
        typeLabel.text = type
        typeLabel.numberOfLines = 0
        typeLabel.textAlignment = .center
        
        stackView.addArrangedSubview(typeLabel)
    }
}
