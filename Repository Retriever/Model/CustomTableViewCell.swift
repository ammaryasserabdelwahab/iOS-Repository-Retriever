//
//  CustomTableViewCell.swift
//  Repository Retriever
//
//  Created by Ammar Yasser on 20/10/2023.
//

import UIKit
import SDWebImage

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var ownerImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()

        ownerImage.layer.masksToBounds = true
        ownerImage.layer.cornerRadius = ownerImage.frame.height / 2
        ownerImage.layer.borderWidth = 1
        ownerImage.layer.borderColor = UIColor.systemTeal.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
//MARK: - Initialize Labels and ImageView
    func commonInit(_ name: String, _ repoName: String, _ image: String){
        ownerNameLabel.text = name
        repoNameLabel.text = repoName
        ownerImage.sd_setImage(with: URL(string: image))
    }
    
}
