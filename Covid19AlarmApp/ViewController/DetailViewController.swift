//
//  DetailViewController.swift
//  Covid19AlarmApp
//
//  Created by Hamlit Jason on 2021/07/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var Header: UILabel! // 지역 위치
    
    var viewModel = DetailViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Header.text = viewModel.location
        
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

