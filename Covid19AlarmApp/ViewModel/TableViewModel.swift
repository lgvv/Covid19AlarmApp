//
//  TableViewModel.swift
//  Covid19AlarmApp
//
//  Created by Hamlit Jason on 2021/07/21.
//

import UIKit

class TableViewModel {
    
    static var shared = TableViewModel() // 싱글톤 객체
    
    
    func myformaat() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let current_date_string = formatter.string(from: Date())
        print(current_date_string)
        return current_date_string
    }
}
