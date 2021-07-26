//
//  DetailViewModel.swift
//  Covid19AlarmApp
//
//  Created by Hamlit Jason on 2021/07/21.
//

import UIKit

class DetailViewModel {
    
    static var shared = DetailViewModel()
    var Model = TableModel.shared // 싱글톤 객체 - 모델
    
    var row : Int! // table indexPath 정보
    
    
}
