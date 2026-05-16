//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Никита Федоров on 11.05.2026.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    
    @IBOutlet private weak var labelOfDate: UILabel!
    @IBOutlet private weak var cellImageView: UIImageView!
    @IBOutlet private weak var likeButton: UIButton!
    
    func imageViewCell(cellIndex: Int ) {
        guard let imageName = UIImage(named: "\(cellIndex)") else { return }
        
        cellImageView.image = imageName
    }
    
    func labelOfDateInCell(date: String) {
        labelOfDate.text = date
    }
    
    func configureLikeButton(cellIndex: Int) {
        let imageName = cellIndex % 2 == 0 ? "noLike" : "like"
        likeButton.setImage(UIImage(named: imageName), for: .normal)
    }
}
