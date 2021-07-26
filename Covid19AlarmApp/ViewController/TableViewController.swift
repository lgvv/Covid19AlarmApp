//
//  TableViewController.swift
//  Covid19AlarmApp
//
//  Created by Hamlit Jason on 2021/07/21.
//

import UIKit

class TableViewController : UIViewController {
   
    var Model = TableModel.shared // 싱글톤 객체 - 모델
    var COVIDAPICALL = LoadCOVID19API.shared // 싱글톤 객체 - 호출
    var tableViewModel = TableViewModel.shared // 싱글톤 객체 - 뷰모델
    var SEARCHAPICALL = LoadSEARCHnewsAPI.shared // 싱글톤 객체 - 호출
    
    override func viewDidLoad() {
        super.viewDidLoad()
        COVIDAPICALL.parsing()
        let queryValue: String = "대전코로나"
        print(queryValue)
        SEARCHAPICALL.requestAPIToNaver(queryValue: queryValue)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            let vc = segue.destination as? DetailViewController
            if let index = sender as? Int { // indexPath.row의 값이 sender통해 전달 돼
                vc?.detailViewModel.row = sender as! Int
                print(Model.books[index].gubun)
            }
            
        }
    }
    
}

extension TableViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableCell
        
        cell.location.text = "\(Model.books[indexPath.row].gubun)"
        cell.today.text = "일일 확진자 수 \(Model.books[indexPath.row].incDec)"
        cell.change.text = "확진자 수 \(Model.books[indexPath.row].defCnt)"
        
        return cell
    }
    
}


extension TableViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "DetailSegue", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // 테이블 뷰 헤더에 넣을 글자
        
        return "기준 날짜 : \(tableViewModel.myformaat() )\(Model.books[0].stdDay)"
    }
}

