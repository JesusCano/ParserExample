//
//  BookTableViewCell.swift
//  ParserExample
//
//  Created by Jesus Jaime Cano Terrazas on 14/08/21.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var book: Book! {
        didSet{
            self.configureCell()
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Private Methods
    
    private func configureCell() {
        titleLabel.text = book.title
        authorLabel.text = book.author
        priceLabel.text = book.price
    }

}
