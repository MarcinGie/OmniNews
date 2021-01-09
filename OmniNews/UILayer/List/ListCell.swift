//
//  ListCell.swift
//  OmniNews
//
//  Created by Marcin on 07/01/2021.
//

import EasyPeasy
import SDWebImage

class ListCell: UITableViewCell {
    func setup(title: String, imageURL: String) {
        selectionStyle = .none
        
        let containerView = UIView()
        contentView.addSubview(containerView)
        containerView.easy.layout(Top(5), Left(5), Right(5), Bottom())
        containerView.layer.cornerRadius = 5.0
        containerView.backgroundColor = .systemGray5
        
        let articleImageView = UIImageView()
        containerView.addSubview(articleImageView)
        articleImageView.easy.layout(Top(5), Left(5), Right(5), Height(100))
        articleImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder"))
        articleImageView.contentMode = .scaleAspectFit
        
        let titleLabel = UILabel()
        containerView.addSubview(titleLabel)
        titleLabel.easy.layout(Top().to(articleImageView, .bottom), Left(5), Right(5), Bottom())
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
    }
    
    func setup(title: String) {
        selectionStyle = .none
        
        let containerView = UIView()
        contentView.addSubview(containerView)
        containerView.easy.layout(Top(5), Left(5), Right(5), Bottom())
        containerView.layer.cornerRadius = 5.0
        containerView.backgroundColor = .systemGray4
        
        let titleLabel = UILabel()
        containerView.addSubview(titleLabel)
        titleLabel.easy.layout(Edges(5))
        titleLabel.text = title
        titleLabel.numberOfLines = 0
    }
}
