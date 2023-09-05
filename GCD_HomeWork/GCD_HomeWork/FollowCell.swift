//
//  FollowCell.swift
//  GCD_HomeWork
//
//  Created by Bach Nghiem on 30/08/2023.
//

import UIKit

final class FollowCell: UITableViewCell, ReusebleTableView {
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var repoLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }
    
    private func config() {
        userImageView.setRadius()
        contentView.layer.cornerRadius = LayoutOptions.radius
        contentView.clipsToBounds = true
    }
    
    func configCell(account: Account) {
        loadImage(image: account.avatarURL)
        nameLabel.text = account.login
        repoLabel.text = account.htmlURL
    }
    
    private func loadImage(image: String) {
        APIRepository.shared.loadImage(stringURL: image) { (data: Data) in
            DispatchQueue.main.async { [weak self] in
                self?.userImageView.image = UIImage(data: data)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
