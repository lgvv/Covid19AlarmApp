//
//  NewsViewController.swift
//  Covid19AlarmApp
//
//  Created by Hamlit Jason on 2021/07/26.
//

import UIKit
import SafariServices

class NewsViewController : UIViewController {
    
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var NewsChangeButton: UIButton!
    
    var detailViewModel = DetailViewModel.shared // 싱글톤 객체
    var Model = TableModel.shared // 싱글톤 객체 - 모델
    var SEARCHAPICALL = LoadSEARCHnewsAPI.shared // 싱글톤 객체 - 호출
    var tableViewModel = TableViewModel.shared // 싱글톤 객체 - 뷰모델
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sectionTitle.text = "🦠 코로나 관련 뉴스"
        //NewsViewController.initRefresh()
        print("ViewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myCollectionView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        SEARCHAPICALL.requestAPIToNaver(queryValue: "코로나")
    }
    
    static func initRefresh() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateUI(refresh: )), for: .valueChanged)
    }
    
    @objc func updateUI(refresh: UIRefreshControl) {
        //refresh.endRefreshing() // 리프레쉬 종료
        myCollectionView.reloadData() // 컬렉션 뷰 리로드
    }
    
    @IBAction func NewsChange(_ sender: Any) {
        /*
         동기화의 문제로
         UI가 APICALL완료보다 먼저 그려지기 때문에, 이전에 데이터의 순환을 활용한다
         */
        if NewsChangeButton.titleLabel?.text == "우리지역 뉴스보기" {
            let queryValue: String = "코로나"
            print(queryValue)
            
            SEARCHAPICALL.requestAPIToNaver(queryValue: queryValue)
            NewsChangeButton.setTitle("전체지역 뉴스보기", for: .normal)
            myCollectionView.reloadData()
        } else {
            let queryValue: String = "\(Model.books[detailViewModel.row].gubun) 코로나"
            
            SEARCHAPICALL.requestAPIToNaver(queryValue: queryValue)
            NewsChangeButton.setTitle("우리지역 뉴스보기", for: .normal)
            myCollectionView.reloadData()
        }
    }
    
}

extension NewsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.shared.searchResult?.items.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as? NewsCell else {
            print("error")
            return UICollectionViewCell()
        }
        cell.title.text = dataManager.shared.searchResult?.items[indexPath.row].title.replacingOccurrences(of: "<[^>]+>|&quot;", with: "", options: .regularExpression, range: nil)
        cell.itemdesc.text = dataManager.shared.searchResult?.items[indexPath.row].itemDescription.replacingOccurrences(of: "<[^>]+>|&quot;", with: "", options: .regularExpression, range: nil)
        return cell
    }
}

extension NewsViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let originallink = dataManager.shared.searchResult?.items[indexPath.row].originallink
        
        guard let url = URL(string: originallink!), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}


extension NewsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let itemSpacing : CGFloat = 10
            
            let width : CGFloat = (collectionView.bounds.width - itemSpacing) / 2
            let height : CGFloat = width + 30
            
            return CGSize(width: width, height: height)
        }
}
