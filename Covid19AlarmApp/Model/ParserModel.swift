//
//  ParserModel.swift
//  Covid19AlarmApp
//
//  Created by Hamlit Jason on 2021/07/21.
//

import Foundation

// Model
class ParserModel {
    
    static var shared = ParserModel() // 싱글톤 객체
    
    var isLock = true
    var tagType : TagType = .none
    var tempModel : item?
    var books: [item] = [] // API 호출에서 받아온 정보를 여기서 담고 있다.
    
}

enum TagType {
    case createDt
    case deathCnt
    case defCnt
    case gubun
    case gubunCn
    case gubunEn
    case incDec
    case isolClearCnt
    case isolIngCnt
    case localOccCnt
    case overFlowCnt
    case qurRate
    case seq
    case stdDay
    case none
}

struct item {
    var createDt: String
    var deathCnt: String
    var defCnt: String
    var gubun: String
    var gubunCn: String
    var gubunEn: String
    var incDec: String
    var isolClearCnt: String
    var isolIngCnt: String
    var localOccCnt: String
    var overFlowCnt: String
    var qurRate: String
    var seq: String
    var stdDay: String
    
    init() {
        createDt = ""
        deathCnt = ""
        defCnt = ""
        gubun = ""
        gubunCn = ""
        gubunEn = ""
        incDec = ""
        isolClearCnt = ""
        isolIngCnt = ""
        localOccCnt = ""
        overFlowCnt = ""
        qurRate = ""
        seq = ""
        stdDay = ""
    }
}
