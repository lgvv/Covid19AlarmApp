//
//  NewsViewController.swift
//  Covid19AlarmApp
//
//  Created by Hamlit Jason on 2021/07/26.
//

import UIKit

class NewsViewController : UIViewController {
    
    @IBOutlet weak var sectionTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension NewsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as? NewsCell else {
            print("error")
            return UICollectionViewCell()
        }
        
        return cell
    }
}

extension NewsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 200)
    }
}
