//
//  TableViewController.swift
//  Covid19AlarmApp
//
//  Created by Hamlit Jason on 2021/07/21.
//

import UIKit

class TableViewController : UIViewController {
   
    var Model = ParserModel.shared // 싱글톤 객체 - 데이터 관리
    var setting = LoadAPIFile.shared // 싱글톤 객체 - 호출
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setting.parsing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailViewController
            
            if let index = sender as? Int { // indexPath.row의 값이 sender통해 전달 돼
                //vc?.Header.text = Model.books[index].gubun // 지역 위치
                DetailViewModel.shared.location = Model.books[index].gubun // 지역 위치
                print(Model.books[index].gubun)
            }
            print("A")
            
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
}
