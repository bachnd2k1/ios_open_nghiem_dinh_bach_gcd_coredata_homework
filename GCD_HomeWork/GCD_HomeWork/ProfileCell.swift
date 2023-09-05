//
//  ProfileCell.swift
//  GCD_HomeWork
//
//  Created by Bach Nghiem on 30/08/2023.
//

import UIKit

protocol UserCellDelegate: AnyObject {
    func userButtonTapped(sender: UIButton)
}

final class ProfileCell: UITableViewCell,ReusebleTableView {
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var repoLabel: UILabel!
    
    var delegate: UserCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }
    
    private func config() {
        userImageView.setRadius()
        contentView.layer.cornerRadius = LayoutOptions.radius
        contentView.clipsToBounds = true
    }
    
    @IBAction private func handleDetailButton(_ sender: UIButton) {
        delegate?.userButtonTapped(sender: sender)
    }
    
    func configCell(account: Account) {
        loadImage(image: account.avatarURL)
        nameLabel.text = account.login
        let attributedText = NSAttributedString(string: account.htmlURL, attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        repoLabel.attributedText = attributedText
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
