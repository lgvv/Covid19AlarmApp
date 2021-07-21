//
//  DetailViewController.swift
//  Covid19AlarmApp
//
//  Created by Hamlit Jason on 2021/07/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var DetailModel = DetailViewModel.detailModel // 싱글톤
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension DetailViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    
}

