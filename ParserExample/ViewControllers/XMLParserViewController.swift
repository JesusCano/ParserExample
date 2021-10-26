//
//  XMLParserViewController.swift
//  ParserExample
//
//  Created by Jesus Jaime Cano Terrazas on 07/08/21.
//

import UIKit
import Alamofire

class XMLParserViewController: UIViewController {
    
    private var auxBook: Book!
    private var auxString = ""
    private var dataSource: [Book] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getBooks()
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
    
    private func getBooks() {
        
        AF.request(Constants.API.xmlURLStr)
            .validate()
            .responseData { response in
                switch response.result {
                
                case .success(let value):
                    print("Data: \(value)")
                    
                    let parser = XMLParser(data: value)
                    parser.delegate = self
                    parser.parse()
                    
                    print("Libros parseados \(self.dataSource.count)")
                    for book in self.dataSource {
                        print(book.title)
                        print("\t \(book.id)")
                        print("\t \(book.author)")
                        print("\t \(book.title)")
                        print("\t \(book.price)")
                        print("\t \(book.publishDate)")
                        print("\t \(book.genre)")
                        print("\t \(book.description)")
                    }
                    
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    print("XML request Error: \(error.localizedDescription)")
                }
            }
    }

}

// MARK: - XMLParserViewController

extension XMLParserViewController: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        print("Open: \(elementName)")
        
        if elementName == Constants.Keys.book {
            auxBook = Book()
            if let bookId = attributeDict[Constants.Keys.id] {
                auxBook.id = bookId
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        print("Key value: \(string)")
        auxString = string
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("Closes: \(elementName)")
        switch elementName {
        case Constants.Keys.author:
            auxBook.author = auxString
        case Constants.Keys.title:
            auxBook.title = auxString
        case Constants.Keys.genre:
            auxBook.genre = auxString
        case Constants.Keys.description:
            auxBook.description = auxString
        case Constants.Keys.price:
            auxBook.price = auxString
        case Constants.Keys.publishDate:
            auxBook.publishDate = auxString
        case Constants.Keys.book:
            dataSource.append(auxBook)
        default:
            print("Nothin to do here ...")
        }
    }
    
}

// MARK: UITableViewDataSource, UITableViewDelegate

extension XMLParserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell") as! BookTableViewCell
        cell.book = dataSource[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
