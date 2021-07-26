//
//  DetailViewController.swift
//  Covid19AlarmApp
//
//  Created by Hamlit Jason on 2021/07/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var Header: UILabel! // 지역 위치
    
    var detailViewModel = DetailViewModel.shared
    var Model = TableModel.shared // 싱글톤 객체 - 모델
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Header.text = "🇰🇷 지역 : \(Model.books[detailViewModel.row].gubun)"
        
    }
}

extension DetailViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailCell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! DetailCell

        if indexPath.row == 0 {
            detailCell.data.text = "\(Model.books[detailViewModel.row].gubun)지역 총 확진자 수 : \(Model.books[detailViewModel.row!].defCnt)"
            print(detailViewModel.row!)
        } else if indexPath.row == 1 {
            detailCell.data.text = "사망자 수: \(Model.books[detailViewModel.row!].deathCnt)"
        } else if indexPath.row == 2 {
            detailCell.data.text = "격리환자 수 : \(Model.books[detailViewModel.row!].isolIngCnt)"
        } else if indexPath.row == 3 {
            detailCell.data.text = " 지역발생 수: \(Model.books[detailViewModel.row!].localOccCnt)"
        } else if indexPath.row == 4 {
            detailCell.data.text = "10만명당 확진자 수: \(Model.books[detailViewModel.row!].qurRate)"
        }
    
        return detailCell
    }
    
}




