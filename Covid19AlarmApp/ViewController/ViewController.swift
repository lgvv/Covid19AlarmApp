//
//  ViewController.swift
//  Covid19AlarmApp
//
//  Created by Hamlit Jason on 2021/07/20.
//

import UIKit

class ViewController : UIViewController, XMLParserDelegate {

    var Model = ParserModel.shared // 싱글톤 객체 - 데이터 관리
    var setting = LoadAPIFile.shared // 싱글톤 객체 - 호출
    
    
    
    override func viewDidLoad() {
        setting.parsing()
    }
    
    @IBAction func tap(_ sender: Any) {
        for i in 0..<Model.books.count {
            print(Model.books[i])
        }
        print(Model.books.count)
    }
    
}
