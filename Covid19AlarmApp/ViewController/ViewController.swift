//
//  ViewController.swift
//  Covid19AlarmApp
//
//  Created by Hamlit Jason on 2021/07/20.
//

import UIKit

class ViewController : UIViewController, XMLParserDelegate {

    var isLock = true
    var tagType : TagType = .none
    var tempModel : item?
    var books: [item] = []
    
    override func viewDidLoad() {
        var parser : XMLParser
        var yourKey = "" // 공공 데이터 포털에서 발급받은 개인 키
        var url = URL(string: "")
        parser = XMLParser(contentsOf: url!)!
        parser.delegate = self
        parser.parse()
    }
    
    ///MARK ::: LOGIC
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        // 태그의 시작
        print(elementName)
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        // 태그의 끝
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let parseString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        print(parseString)
        //print(parseString)
        //books.append(parseString)
    }
    
    @IBAction func tap(_ sender: Any) {
        for i in 0..<books.count {
            print(books[i])
        }
        print(books.count)
    }
    
}
