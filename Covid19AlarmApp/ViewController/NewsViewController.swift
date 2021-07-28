//
//  NewsViewController.swift
//  Covid19AlarmApp
//
//  Created by Hamlit Jason on 2021/07/26.
//

import UIKit

class NewsViewController : UIViewController {
    
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var detailViewModel = DetailViewModel.shared // 싱글톤 객체
    var Model = TableModel.shared // 싱글톤 객체 - 모델
    var SEARCHAPICALL = LoadSEARCHnewsAPI.shared // 싱글톤 객체 - 호출
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sectionTitle.text = "🦠 코로나 관련 뉴스"
        //NewsViewController.initRefresh()
        print("ViewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myCollectionView.reloadData()
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
        let queryValue: String = "코로나"
        print(queryValue)
        SEARCHAPICALL.requestAPIToNaver(queryValue: queryValue)
        myCollectionView.reloadData()
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
        
        cell.title.text = dataManager.shared.searchResult?.items[indexPath.row].title
        cell.itemdesc.text = dataManager.shared.searchResult?.items[indexPath.row].itemDescription
        return cell
    }
}

extension NewsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let itemSpacing : CGFloat = 10
            let textAreaHeight : CGFloat = 65
            
            let width : CGFloat = (collectionView.bounds.width - itemSpacing) / 2
            let height : CGFloat = width + 30
            
            return CGSize(width: width, height: height)
        }
}
