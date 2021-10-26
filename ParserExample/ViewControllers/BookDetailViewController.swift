//
//  BookDetailViewController.swift
//  ParserExample
//
//  Created by Jesus Jaime Cano Terrazas on 14/08/21.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var bookDetail: Book!
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var publishDateLable: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configureView()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Private Methods
    
    private func configureView() {
        self.bookTitle.text = bookDetail.title
        self.authorLabel.text = bookDetail.author
        self.genreLabel.text = bookDetail.genre
        self.priceLabel.text =  bookDetail.price
        self.publishDateLable.text = bookDetail.publishDate
        self.descriptionLabel.text = bookDetail.description
    }

}
