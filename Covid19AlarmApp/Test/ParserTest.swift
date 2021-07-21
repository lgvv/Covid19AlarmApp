//
//  ViewController.swift
//  Covid19AlarmApp
//
//  Created by Hamlit Jason on 2021/07/20.
//

import UIKit

struct Book {
    var bookTitle: String
    var bookAuthor: String
}


class ParserTest : UIViewController, XMLParserDelegate {
    
    var books: [Book] = []
    var elementName: String = String()
    var bookTitle = String()
    var bookAuthor = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("zx")
        if let path = Bundle.main.url(forResource: "Books", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
                print("ASDDDD")
            }
        }
        print("zx")
    }
    
    
    
    // 1
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

        if elementName == "book" {
            bookTitle = String()
            bookAuthor = String()
        }

        self.elementName = elementName
    }

    // 2
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "book" {
            let book = Book(bookTitle: bookTitle, bookAuthor: bookAuthor)
            books.append(book)
            print("ASD")
        }
    }

    // 3
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if (!data.isEmpty) {
            if self.elementName == "title" {
                bookTitle += data
            } else if self.elementName == "author" {
                bookAuthor += data
            }
        }
    }
    
    
    @IBAction func tap(_ sender: Any) {
        print(books[1])
    }
    
}
