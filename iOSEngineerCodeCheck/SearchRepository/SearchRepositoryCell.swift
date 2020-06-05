//
//  SearchRepositoryCell.swift
//  iOSEngineerCodeCheck
//
//  Created by 塩見陵介 on 2020/06/04.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SearchRepositoryCell: UITableViewCell {
    
    @IBOutlet weak var repositoryTitle: UILabel!
    @IBOutlet weak var usedLanguage:    UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
