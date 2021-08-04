//
//  DetailViewController.swift
//  Covid19AlarmApp
//
//  Created by Hamlit Jason on 2021/07/21.
//

import UIKit

/*
 UserDefault
  - BellCheck : 벨이 켜졌는가 꺼졌는가?
  - BellLocation : 켜졌다면 어느 지역을 선택했는가?
 */
class DetailViewController: UIViewController {
    
    @IBOutlet weak var Header: UILabel! // 지역 위치
    @IBOutlet weak var NewsView: UIView!
    @IBOutlet weak var naviRightItem: UIBarButtonItem!
    
    var detailViewModel = DetailViewModel.shared
    var Model = TableModel.shared // 싱글톤 객체 - 모델
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Header.text = "🇰🇷 지역 : \(Model.books[detailViewModel.row].gubun)"
        naviImageSet()
    }
    
    @IBAction func naviRightItemClicked(_ sender: Any) {
        
        if UserDefaults.standard.integer(forKey: "BellCheck") == 1 && UserDefaults.standard.string(forKey: "BellLocation") == Model.books[detailViewModel.row].gubun {
            UserDefaults.standard.set(0, forKey: "BellCheck")
            self.naviRightItem.image = UIImage(systemName: "bell")
            alert("매일 아침 알림을 헤제되었습니다.") {
                UserDefaults.standard.set("nothing", forKey: "BellLocation") // 어떤 지역을 on했는가
                self.naviRightItem.image = UIImage(systemName: "bell.slash")
            }
        } else {
            UserDefaults.standard.set(1, forKey: "BellCheck") // 벨 이미지의 상태
            alert("매일 아침 알림을 등록되었습니다.") {
                UserDefaults.standard.set(self.Model.books[self.detailViewModel.row].gubun, forKey: "BellLocation") // 어떤 지역을 on했는가
                self.naviRightItem.image = UIImage(systemName: "bell")
            }
        }
        
    }
    
    
}

extension DetailViewController : UITableViewDataSource, UITableViewDelegate {
    
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

extension DetailViewController {
    
    func alert(_ message : String, completion : (()->Void)? = nil) {
        
        // 메인 스레드에서 실행하도록 변경
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "확인", style: .cancel) { (_) in
                completion?() // completion 매개변수의 값이 nil이 아닐 때에만 실행되도록
            }
            
            alert.addAction(okAction)
            self.present(alert, animated: false, completion: nil)
        }
    }
    
    
    func naviImageSet() {
        for _ in 0..<Model.books.count {
            if UserDefaults.standard.string(forKey: "BellLocation") == Model.books[detailViewModel.row].gubun {
                self.naviRightItem.image = UIImage(systemName: "bell")
                break
            }
        }
    }
}




