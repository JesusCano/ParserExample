//
//  JSONParserViewController.swift
//  ParserExample
//
//  Created by Jesus Jaime Cano Terrazas on 08/08/21.
//

import UIKit
import Alamofire

class JSONParserViewController: UIViewController {
    
    private var dataSource: [Book] = []
    @IBOutlet weak var tableView: UITableView!
    private var refreshControl = UIRefreshControl()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(getBooks), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        self.getBooks()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // Important thing, when you need to pass information from the first controller to the second one, take care where you put the segue, because you can create a double segue
        // Example, I need to go from book list controller with the detail of the book selected, so, if you put the segue from the cell, you will have a event duplicated, so, you need to move this segue to the entire controll
        
        
        if segue.identifier == "BookDetailViewController" {
            
            let bookDetailViewController = segue.destination as! BookDetailViewController
            
            if let bookToSend = sender as? Book {
                bookDetailViewController.bookDetail = bookToSend
            }
        }
    }
    
    // MARK: - Private Methods
    
    @objc private func getBooks() {
        
        AF.request(Constants.API.jsonURLStr).validate().responseData { response in
            switch response.result {
            case .success(let value):
                print("JSON Data: \(value)")
                
                do {
                    let booksResponse = try JSONDecoder().decode((BooksResponseModel.self), from: value)
                    
                    print("Libros Parseados: \(booksResponse.catalog.books.count)")
                    self.dataSource = booksResponse.catalog.books
                    self.dataSource[0].price = "10"
                    self.tableView.reloadData()
                    
                } catch let error {
                    print("Decode Error: \(error.localizedDescription)")
                }
                
            case .failure(let error):
                print("JSON request error: \(error.localizedDescription)")
            }
            
            self.refreshControl.endRefreshing()
        }
    }
    
    

}


// MARK: UITableViewDataSource, UITableViewDelegate

extension JSONParserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell") as! BookTableViewCell
        cell.book = dataSource[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookSelected = self.dataSource[indexPath.row]
        performSegue(withIdentifier: "BookDetailViewController", sender: bookSelected)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
