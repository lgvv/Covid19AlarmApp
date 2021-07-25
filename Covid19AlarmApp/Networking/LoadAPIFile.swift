//
//  LoadAPIFile.swift
//  Covid19AlarmApp
//
//  Created by Hamlit Jason on 2021/07/21.
//

import Foundation
import UIKit

// API CALL
class LoadAPIFile : UIViewController, XMLParserDelegate {
    
    var Model = TableModel.shared // 싱글톤 객체
    static var shared = LoadAPIFile()
    
    func parsing() {
        var parser : XMLParser
        let url = URL(string: APIKey)
        parser = XMLParser(contentsOf: url!)!
        parser.delegate = self
        parser.parse()
    }
    
    
    ///MARK ::: LOGIC
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        // 태그의 시작
        print("start")
        if elementName == "item" {
            Model.isLock = true
            Model.tempModel = item.init()
        } else if elementName == "createDt" {
            Model.tagType = .createDt
        } else if elementName == "deathCnt" {
            Model.tagType = .deathCnt
        } else if elementName == "defCnt" {
            Model.tagType = .defCnt
        } else if elementName == "gubun" {
            Model.tagType = .gubun
        } else if elementName == "gubunCn" {
            Model.tagType = .gubunCn
        } else if elementName == "gubunEn" {
            Model.tagType = .gubunEn
        } else if elementName == "incDec" {
            Model.tagType = .incDec
        } else if elementName == "isolClearCnt" {
            Model.tagType = .isolClearCnt
        } else if elementName == "isolIngCnt" {
            Model.tagType = .isolIngCnt
        } else if elementName == "localOccCnt" {
            Model.tagType = .localOccCnt
        } else if elementName == "overFlowCnt" {
            Model.tagType = .overFlowCnt
        } else if elementName == "qurRate" {
            Model.tagType = .qurRate
        } else if elementName == "seq" {
            Model.tagType = .seq
        } else if elementName == "stdDay" {
            Model.tagType = .stdDay
        } else {
            Model.tagType = .none
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            print("end")
            guard let tempModel = Model.tempModel else {
                return
            }
            Model.books.append(tempModel)
            Model.isLock = false
        } else {
            print("----- didEndElement \(elementName)-----")
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let parseString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        print(parseString)
        if Model.isLock {
            switch Model.tagType {
            case .createDt:
                Model.tempModel?.createDt = parseString
            case .deathCnt:
                Model.tempModel?.deathCnt = parseString
            case .defCnt:
                Model.tempModel?.defCnt = parseString
            case .gubun:
                Model.tempModel?.gubun = parseString
            case .gubunCn:
                Model.tempModel?.gubunCn = parseString
            case .gubunEn:
                Model.tempModel?.gubunEn = parseString
            case .incDec:
                Model.tempModel?.incDec = parseString
            case .isolClearCnt:
                Model.tempModel?.isolClearCnt = parseString
            case .isolIngCnt:
                Model.tempModel?.isolIngCnt = parseString
            case .localOccCnt:
                Model.tempModel?.localOccCnt = parseString
            case .overFlowCnt:
                Model.tempModel?.overFlowCnt = parseString
            case .qurRate:
                Model.tempModel?.qurRate = parseString
            case .seq:
                Model.tempModel?.seq = parseString
            case .stdDay:
                Model.tempModel?.stdDay = parseString
            case .none: break
            }
        }
        
    }
}
